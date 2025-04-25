{ builder }: { name, src }: if builtins.pathExists src then builder {
  inherit name src;
  pname = name;
  vscodeExtUniqueId = name;
  vscodeExtName = name;
  vscodeExtPublisher = "me";
  version = "0.0.0";
} else null
