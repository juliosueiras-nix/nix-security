{ pkgs, ... }:

{
  inherit (pkgs) cifs-utils netkittftp iw lvm2 mlocate libressl nfs-utils openssh openvpn p7zip parted utillinux samba net-snmp sudo tcpdump testdisk tightvnc tmux unrar vim whois;
}


