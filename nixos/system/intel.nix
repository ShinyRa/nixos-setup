{ config, lib, pkgs, modulesPath, ... }:

{
  boot.kernelModules = [ "kvm-intel" ];
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];  # bbswitch
  boot.kernelParams = [ "acpi_rev_override=5" "i915.enable_guc=2" ]; 

  services.xserver = {
      videoDrivers = ["intel"];
  };

  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver # LIBVA_DRIVER_NAME=iHD
    vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    vaapiVdpau
    libvdpau-va-gl
    intel-compute-runtime
  ];
}