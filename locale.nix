{ config, pkgs, ... }:

{

  # Locale
  i18n = {
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Timezone
  time.timeZone = "Europe/London";

}
