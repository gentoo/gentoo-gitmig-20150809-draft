# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mol/mol-0.9.69_pre2.ebuild,v 1.1 2003/05/24 23:59:36 lu_zero Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="MOL (Mac-on-Linux) lets PPC users run MacOS (X) under Linux (rsync snapshot)"
SRC_URI="http://cvs.gentoo.org/~lu_zero/distfiles/${P}.tar.bz2"
HOMEPAGE="http://www.maconlinux.net/"

DEPEND=">=sys-kernel/ppc-sources-benh-2.4.20-r10"
RDEPEND="net-misc/dhcp
	net-firewall/iptables"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc -x86 -sparc -alpha -mips"
IUSE=""

src_compile() {

	filter-flags -fsigned-char

	# dhcp config fix and show dchpd messages on starting mol
	cd ${S}
	sed -i "s:#ddns-update-style:ddns-update-style:g" Doc/config/dhcpd-mol.conf || die
	sed -i "s:DHCPD\ -q\ -cf:DHCPD\ -cf:g" Doc/config/tunconfig || die

	./autogen.sh
	./configure --prefix=/usr || die "This is a ppc-only package (time to buy that iBook, no?)"
	make || die "Failed to compile MOL"
	make libimport || die "Failed to compile MOL"

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
