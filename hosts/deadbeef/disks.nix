{device ? throw "Set this to your primary disk", ...}: {
  disko.devices = {
    disk.main = {
      inherit device;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
              ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              settings = {
                allowDiscards = true;
              };
              content = {
                type = "btrfs";
                extraArgs = ["--force"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                  };

                  "/persist" = {
                    mountOptions = ["subvol=persist" "noatime"];
                    mountpoint = "/persist";
                  };

                  "/nix" = {
                    mountOptions = ["subvol=nix" "noatime"];
                    mountpoint = "/nix";
                  };
		  "/swap" = {
		    mountpoint = "/.swap";
                    swap.swapfile.size = "32G";
		  };
                };
              };
            };
          };
        };
      };
    };
  };
}
