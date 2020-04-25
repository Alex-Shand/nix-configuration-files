{ config, pkgs, ... }:

{

  # Locale
  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Timezone
  time.timeZone = "Europe/London";

}
