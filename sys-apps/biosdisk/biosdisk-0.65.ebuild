# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/biosdisk/biosdisk-0.65.ebuild,v 1.2 2005/01/04 00:10:25 pkdawson Exp $

DESCRIPTION="A script that creates floppy boot images to flash Dell BIOSes"
HOMEPAGE="http://linux.dell.com/projects.shtml#biosdisk"
SRC_URI="http://linux.dell.com/biosdisk/permalink/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="app-text/unix2dos
	sys-boot/syslinux"

src_install() {
	dosbin biosdisk
	dosbin blconf

	dodoc AUTHORS CHANGELOG README README.dosdisk TODO VERSION
	doman biosdisk.8.gz

	insinto /usr/share/biosdisk
	doins dosdisk.img
	doins biosdisk-mkrpm-redhat-template.spec
	doins biosdisk-mkrpm-generic-template.spec

	insinto /etc
	doins biosdisk.conf
}
