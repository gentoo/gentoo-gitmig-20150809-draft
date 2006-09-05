# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mol/mol-0.9.71_pre8-r1.ebuild,v 1.1 2006/09/05 18:46:59 josejx Exp $

inherit flag-o-matic eutils linux-mod

DESCRIPTION="MOL (Mac-on-Linux) lets PPC users run MacOS (X) under Linux (rsync snapshot)"
HOMEPAGE="http://www.maconlinux.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc"
IUSE="vnc alsa oss fbcon X oldworld sheep debug dga usb pci"

MAKEOPTS="${MAKEOPTS} -j1"
RDEPEND="net-misc/dhcp
	net-firewall/iptables
	alsa? ( virtual/alsa )
	vnc? ( net-misc/vnc )
	X? ( || ( ( x11-libs/libXext
				dga? ( x11-libs/libXxf86dga )
			  )
			  virtual/x11
			)
	)"
DEPEND="${RDEPEND}
	X? ( || ( ( x11-libs/libXt
			    x11-proto/xextproto
				dga? ( x11-proto/xf86dgaproto )
			  )
			  virtual/x11
			)
	)"

MODULE_NAMES="mol(mol:${S}/src/kmod/Linux)
			  sheep(net:${S}/src/netdriver)"

pkg_setup() {
	echo
	einfo "If you want to use MOL fullscreen on a virtual console"
	einfo "be sure to have the USE-flag \"fbcon\" set!"
	echo

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# PCI Debugging Patch
	if use debug; then
		epatch ${FILESDIR}/${PN}-pciproxy-dump.patch
	fi

	epatch ${FILESDIR}/${P}-to-pre9.patch
}

src_compile() {
	filter-flags -fsigned-char
	append-flags -D_FILE_OFFSET_BITS=64
	append-flags -D_LARGE_FILES

	export KERNEL_SOURCE="/usr/src/${FK}"
	export LDFLAGS=""

	# initialize all needed build-files
	./autogen.sh
	./configure --prefix="/usr" || die "Configure failed."

	# workaround for proper module-building
	emake defconfig || die "Make failed."

	sed -i "s:CONFIG_XDGA=y:# CONFIG_XDGA is not set:" .config-ppc
	sed -i "s:CONFIG_TAP=y:# CONFIG_TAP is not set:" .config-ppc
	sed -i "s:CONFIG_TUN=y:# CONFIG_TUN is not set:" .config-ppc
	use alsa     || sed -i "s:CONFIG_ALSA=y:# CONFIG_ALSA is not set:" .config-ppc
	use debug    && sed -i "s:# CONFIG_DEBUGGER is not set:CONFIG_DEBUGGER=y:" .config-ppc
	use oss      || sed -i "s:CONFIG_OSS=y:# CONFIG_OSS is not set:" .config-ppc
	use oldworld || sed -i "s:CONFIG_OLDWORLD=y:# CONFIG_OLDWORLD is not set:" .config-ppc
	use sheep    || sed -i "s:CONFIG_SHEEP=y:# CONFIG_SHEEP is not set:" .config-ppc
	use X        || sed -i "s:CONFIG_X11=y:# CONFIG_X11 is not set:" .config-ppc
	use fbcon    || sed -i "s:CONFIG_FBDEV=y:# CONFIG_FBDEV is not set:" .config-ppc
	use vnc      || sed -i "s:CONFIG_VNC=y:# CONFIG_VNC is not set:" .config-ppc
	use dga      || sed -i "s:CONFIG_XDGA=y:# CONFIG_XDGA is not set:" .config-ppc
	use usb      || sed -i "s:CONFIG_USBDEV=y:# CONFIG_USBDEV is not set:" .config-ppc
	use pci		 || sed -i "s:CONFIG_PCIPROXY=y:# CONFIG_PCIPROXY is not set:" .config-ppc

	einfo "The configuration has been altered according to your USE-flags."
	# reinitialize our changed configuration
	emake oldconfig

	cd ${S}
	emake BUILD_MODS=n || die "Build failed."

	# Build the modules too!
	BUILD_PARAMS="KERNEL_SOURCE=${KV_DIR} LV=${KV_MAJOR}${KV_MINOR} MP=${KV_OBJ}
				  KUNAME=${KV}"
	BUILD_TARGETS=all
	linux-mod_src_compile
}

src_install() {
	#linux-mod_src_install
	cd ${S}
	emake DESTDIR=${D} install || die "Failed to install"
	dodoc CREDITS Doc/Boot-ROM Doc/NewWorld-ROM Doc/Sound Doc/Video
	dodoc Doc/Networking Doc/Dev/Debugger Doc/Dev/Addresses
	dodoc Doc/man/molvconfig.1 Doc/man/startmol.1 Doc/man/molrc.5
	insinto /var/lib/mol
	doins ${S}/mollib/nvram/nvram.x
}

pkg_postinst() {
	echo
	einfo "Mac-on-Linux is now installed.  To run, use the command startmol."
	einfo "You might want to configure video modes first with molvconfig."
	einfo "Other configuration is in /etc/molrc.  For more info see:"
	einfo "              http://www.maconlinux.org"
	einfo "Also try man molrc, man molvconfig, man startmol"
	echo
	ewarn "For networking and sound you might install the drivers in the"
	ewarn "folder \"MOL-Install\" on your Mac OS X-Desktop."
	echo
	ewarn "If errors with networking occur, make sure you have the following"
	ewarn "kernel functions enabled:"
	einfo "For connecting to Linux:"
	einfo "    Universal TUN/TAP device driver support (CONFIG_TUN)"
	einfo "For the dhcp server:"
	einfo "    Packet Socket (CONFIG_PACKET)"
	einfo "For NAT:"
	einfo "    Network packet filtering (CONFIG_NETFILTER)"
	einfo "    Connection tracking (CONFIG_IP_NF_CONNTRACK)"
	einfo "    IP tables support (CONFIG_IP_NF_IPTABLES)"
	einfo "    Packet filtering (CONFIG_IP_NF_FILTER)"
	einfo "    Full NAT (CONFIG_IP_NF_NAT)"
	einfo "    MASQUERADE target support (CONFIG_IP_NF_TARGET_MASQUERADE)"
	echo
}
