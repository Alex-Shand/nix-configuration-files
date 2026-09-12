#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p python3

import os
from pathlib import Path
import subprocess
import shutil

SELF = Path(__file__).resolve()

NIXOS_DIR = Path('/etc/nixos')
HARDWARE_CONFIGURATION_SAFE = '/root/hardware-configuration.nix'

USER = 'alex'
HOME_DIR = Path(f'/home/{USER}')
CONFIG_DIR = HOME_DIR/'.nix-config'

REPO = 'https://github.com/Alex-Shand/nix-configuration-files.git'

def main():
    directory = SELF.parent
    if directory == NIXOS_DIR:
        do_stage_1()
        return
    if directory == CONFIG_DIR:
        do_stage_2()
        return
    print(f'Script should be in {NIXOS_DIR} or {CONFIG_DIR}, was in {directory}')

def run(*cmd):
    subprocess.run(cmd, check=True, capture_output=False)

def capture(*cmd):
    return subprocess.run(cmd, check=True, capture_output=True, text=True).stdout.strip()

def do_stage_1():
    if os.geteuid() != 0:
        run('sudo', SELF)
        return
    run('nix-channel', '--add', 'https://nixos.org/channels/nixos-unstable', 'unstable')
    os.chdir(NIXOS_DIR)
    match repo_status():
        case 'LocalOnly':
            print('Repository has no known remote, refusing to migrate')
            return
        case 'Dirty':
            print('Repository has un-committed changes, commit outstanding changes or reset to HEAD and re-run')
            return
        case 'Diverged' | 'Ahead' | 'Behind':
            print('Repository is not in sync with remote, resolve before re-running')
            return
        case 'UpToDate':
            pass
        case _:
            raise Exception('Unexpected RepoStatus')
    safe_delete(CONFIG_DIR)
    CONFIG_DIR.mkdir(parents=True)
    run('chown', '-R', USER, CONFIG_DIR)
    run('sudo', '-u', USER, 'git', 'clone', REPO, CONFIG_DIR)
    os.chdir('/')
    os.rename(NIXOS_DIR/'hardware-configuration.nix', HARDWARE_CONFIGURATION_SAFE)
    shutil.rmtree(NIXOS_DIR)
    run('ln', '--symbolic', CONFIG_DIR, NIXOS_DIR)
    run('ln', '--symbolic', HARDWARE_CONFIGURATION_SAFE, CONFIG_DIR)
    os.chdir(CONFIG_DIR)
    run('sudo', '-u', USER, 'git', 'config', '--local', 'include.path', '../.gitconfig')
    run(CONFIG_DIR/ME.name)

def repo_status():
    result = subprocess.run(('git', 'config', '--get', 'remote.origin.url'), check=False, capture_output=True, text=True)
    if result.returncode != 0:
        return 'LocalOnly'
    status = capture('git', 'status', '--porcelain')
    if status:
        return 'Dirty'

    run('git', 'fetch')
    ahead_count = int(capture('git', 'rev-list', '--count', 'HEAD..@{u}'))
    behind_count = int(capture('git', 'rev-list', '--count', '@{u}..HEAD'))

    if ahead_count == 0 and behind_count == 0:
        return 'UpToDate'
    if ahead_count > 0 and behind_count > 0:
        return 'Diverged'
    if ahead_count > 0:
        return 'Ahead'
    return 'Behind'

def do_stage_2():
    if os.geteuid() != 0:
        run('sudo', SELF)
        return
    if NIXOS_DIR.resolve() != CONFIG_DIR:
        print(f"Symlink from {NIXOS_DIR} to {CONFIG_DIR} isn't in place.")
        print(f'Double check that hardware-configuration.nix is safely stored in {HARDWARE_CONFIGURATION_SAFE}')
        print(f'Then delete {NIXOS_DIR} and run sudo ln -s {CONFIG_DIR} {NIXOS_DIR}')
        print(f"Also run ln -s {HARDWARE_CONFIGURATION_SAFE} {CONFIG_DIR/'hardware-configuration.nix'} if it isn't present in {CONFIG_DIR}")
    run('nixos-rebuild', 'boot')
    run('reboot')

def safe_delete(path):
    try:
        shutil.rmtree(CONFIG_DIR)
    except FileNotFoundError:
        pass

def todo():
    raise Exception('todo')

if __name__ == '__main__':
    main()