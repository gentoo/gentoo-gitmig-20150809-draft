# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mol/mol-0.9.68-r4.ebuild,v 1.3 2004/02/20 06:08:34 mr_bones_ Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}-${PR}
DESCRIPTION="MOL (Mac-on-Linux) lets PPC users run MacOS (X) under Linux"
SRC_URI="http://cvs.gentoo.org/~gerk/distfiles/${P}-${PR}.tar.bz2"
HOMEPAGE="http://www.maconlinux.net/"

DEPEND=""
RDEPEND="net-misc/dhcp
	net-firewall/iptables
	>=sys-apps/sed-4.0.5"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc -x86 -sparc -alpha -mips"
IUSE=""

src_compile() {

	filter-flags -fsigned-char

	# dhcp config fix and show dchpd messages on starting mol
	cd ${S}
	sed -i "s:#ddns-update-style:ddns-update-style:g" Doc/config/dhcpd-mol.conf || die
	sed -i "s:DHCPD\ -q\ -cf:DHCPD\ -cf:g" Doc/config/tunconfig || die

	./configure --prefix=/usr || die "This is a ppc-only package (time to buy that iBook, no?)"
	emake || die "Failed to compile MOL"

}

src_install() {

	emake DESTDIR=${D} install || die "Failed to install MOL"

	dodoc 0README BUILDING COPYING COPYRIGHT CREDITS Doc/*

}

pkg_postinst() {
	echo
	einfo "Mac-on-Linux is now installed.  To run, use the command startmol."
	einfo "You might want to configure video modes first with molvconfig."
	einfo "Other configuration is in /etc/molrc.  For more info see:"
	einfo "              www.maconlinux.net"
	einfo "Also try man molrc, man molvconfig, man startmol"
	echo
	einfo "For networking and sound you might install the drivers in the"
	einfo "folder \"MOL-Install\" on your Mac OS X-Desktop."
	echo
	einfo "If errors with networking occur, make sure you have the following"
	einfo "kernel functions enabled:"
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
