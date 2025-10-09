{ config, pkgs, ... }:

{
  # Locale
  console.keyMap = "us";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocales = [ "all" ];

  # Timezone
  time.timeZone = "Europe/London";
}
