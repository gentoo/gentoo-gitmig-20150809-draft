# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mol/mol-0.9.68-r2.ebuild,v 1.2 2003/03/02 01:19:15 gerk Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}-${PR}
DESCRIPTION="MOL (Mac-on-Linux) lets PPC users run MacOS under Linux"
SRC_URI="http://cvs.gentoo.org/~gerk/distfiles/${P}-${PR}.tar.bz2"
HOMEPAGE="http://www.maconlinux.net/"

DEPEND=""
RDEPEND="net-misc/dhcp
	sys-apps/iptables
	>=sys-apps/sed-4.0.5"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc -x86 -sparc -alpha -mips"
IUSE=""

src_compile() {

	filter-flags -fsigned-char

	# dhcp config fix
	cd ${S}
	sed -i "s:#ddns-update-style:ddns-update-style:g" Doc/config/dhcpd-mol.conf || die 
	
	./configure --prefix=/usr || die "This is a ppc-only package (time to buy that iBook, no?)"
	emake || die "Failed to compile MOL"

}

src_install() {

	emake DESTDIR=${D} install || die "Failed to install MOL"

	dodoc 0README BUILDING COPYING COPYRIGHT CREDITS Doc/*

}

pkg_postinst() {
	einfo "Mac-on-Linux is now installed.  To run, use the command startmol"
	einfo "You might want to configure video modes first with molvconfig"
	einfo "Other configuration is in /etc/molrc.  For more info see:"
	einfo "              www.maconlinux.net"
	einfo "Also try man molrc, man molvconfig, man startmol"
	einfo "For networking and sound you might install the Drivers in the"
	einfo "folder \"MOL-Install\" on your Mac OS X-Desktop."
}
