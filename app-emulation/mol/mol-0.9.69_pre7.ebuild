# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mol/mol-0.9.69_pre7.ebuild,v 1.1 2004/01/08 04:27:20 pylon Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="MOL (Mac-on-Linux) lets PPC users run MacOS (X) under Linux (rsync snapshot)"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.maconlinux.net/"

DEPEND=">=sys-apps/sed-4"
RDEPEND="net-misc/dhcp
	net-firewall/iptables
	alsa? ( virtual/alsa )
	esd? ( media-sound/esound )
	X? ( virtual/x11 )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~ppc64 -x86 -sparc -alpha -mips"
IUSE="alsa esd debug oldworld X"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/26-arch-fix.patch || die
}

src_compile() {

	local myconf
	use alsa     || myconf="${myconf} --disable-alsa"
	use debug    || myconf="${myconf} --disable-debugger"
	use esd      && myconf="${myconf} --enable-esd"
	use oldworld || myconf="${myconf} --disable-oldworld"
	use X        && myconf="${myconf} --with-x"

	einfo "MOL will be build with the following options:"
	einfo "${myconf}"

	filter-flags -fsigned-char

	# dhcp config fix and show dchpd messages on starting mol
	cd ${S}
	sed -i "s:#ddns-update-style:ddns-update-style:g" Doc/config/dhcpd-mol.conf || die
	sed -i "s:DHCPD\ -q\ -cf:DHCPD\ -cf:g" Doc/config/tunconfig || die
	export KERNEL_SOURCE="/usr/src/linux"
	./autogen.sh
	./configure ${myconf} --prefix=/usr || die "This is a ppc-only package (time to buy that iBook, no?)"

	addwrite "/usr/src/${FK}"

	emake || die
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
