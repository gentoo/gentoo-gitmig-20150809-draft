# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mol/mol-0.9.70.ebuild,v 1.2 2004/03/22 01:39:51 dholm Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="MOL (Mac-on-Linux) lets PPC users run MacOS (X) under Linux"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.maconlinux.net/"

DEPEND=""
RDEPEND="net-misc/dhcp
	net-firewall/iptables
	alsa? ( virtual/alsa )
	X? ( virtual/x11 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc -x86 -sparc -alpha -mips"
IUSE="alsa oss fbcon X oldworld sheep debug"

pkg_setup() {
	echo
	einfo "If you want to use MOL fullscreen on a virtual console"
	einfo "be sure to have the USE-flag \"fbcon\" set!"
	echo
}

src_unpack() {
	unpack ${A}

	# dhcp config fix and show dchpd messages on starting mol
	cd ${S}
	sed -i "s:#ddns-update-style:ddns-update-style:g" Doc/config/dhcpd-mol.conf || die
	sed -i "s:DHCPD\ -q\ -cf:DHCPD\ -cf:g" Doc/config/tunconfig || die

	sed -i "s:prefix		= /usr/local:prefix		= /usr:" Makefile.top || die
	sed -i "s#VENDOR		:=#VENDOR		:= -gentoo#" Makefile.top || die

}

src_compile() {
	filter-flags -fsigned-char

	export KERNEL_SOURCE="/usr/src/${FK}"

	# initialize all needed build-files
	./autogen.sh

	emake defconfig || die "This is a ppc-only package (time to buy that iBook, no?)"

	sed -i "s:CONFIG_XDGA=y:# CONFIG_XDGA is not set:" .config
	sed -i "s:CONFIG_TAP=y:# CONFIG_TAP is not set:" .config
	use alsa     || sed -i "s:CONFIG_ALSA=y:# CONFIG_ALSA is not set:" .config
	use debug    && sed -i "s:# CONFIG_DEBUGGER is not set:CONFIG_DEBUGGER=y:" .config
	use oss      || sed -i "s:CONFIG_OSS=y:# CONFIG_OSS is not set:" .config
	use oldworld || sed -i "s:CONFIG_OLDWORLD=y:# CONFIG_OLDWORLD is not set:" .config
	use sheep    || sed -i "s:CONFIG_SHEEP=y:# CONFIG_SHEEP is not set:" .config
	use X        || sed -i "s:CONFIG_X11=y:# CONFIG_X11 is not set:" .config
	use fbcon    || sed -i "s:CONFIG_FBDEV=y:# CONFIG_FBDEV is not set:" .config

	einfo "The configuration has been altered according to your USE-flags."
	# reinitialize our changed configuration
	emake oldconfig

	addwrite "/usr/src/${FK}"
	emake || die "Build mol with: FEATURES=\"-userpriv -strict\" emerge mol"
}

src_install() {
	# MOL needs write access to some .depend-files in the kernel-dir
	# (at least arch/ppc/) to build the kernel-modules.  With
	# sandboxing enabled this would result in an access violation.

	addwrite "/usr/src/${FK}"
	emake DESTDIR=${D} install || die "Failed to install MOL."

	dodoc 0README BUILDING COPYRIGHT CREDITS Doc/*
}

pkg_postinst() {
	echo
	einfo "Mac-on-Linux is now installed.  To run, use the command startmol."
	einfo "You might want to configure video modes first with molvconfig."
	einfo "Other configuration is in /etc/molrc.  For more info see:"
	einfo "              http://www.maconlinux.net"
	einfo "Also try man molrc, man molvconfig, man startmol"
	echo
	ewarn "For networking and sound you might install the drivers in the"
	ewarn "folder \"MOL-Install\" on your Mac OS X-Desktop."
	echo
	ewarn "If errors with networking occur, make sure you have the following"
	ewarn "kernel functions enabled:"
	einfo "For the dhcp server:"
	einfo "    Socket Filtering (CONFIG_FILTER)"
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
