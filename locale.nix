{ config, pkgs, ... }:

{
  # Locale
  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  # Timezone
  time.timeZone = "Europe/London";
}
