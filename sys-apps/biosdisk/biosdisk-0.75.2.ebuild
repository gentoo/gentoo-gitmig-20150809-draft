# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/biosdisk/biosdisk-0.75.2.ebuild,v 1.1 2008/10/01 10:32:09 bangert Exp $

inherit versionator

MY_PV=$(replace_version_separator 2 '-')
S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)
DESCRIPTION="A script that creates floppy boot images to flash Dell BIOSes"
HOMEPAGE="http://linux.dell.com/projects.shtml#biosdisk"
SRC_URI="http://linux.dell.com/biosdisk/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="app-text/unix2dos
	sys-boot/syslinux"

src_install() {
	dosbin biosdisk
	dosbin blconf

	dodoc AUTHORS README README.dosdisk TODO VERSION
	doman biosdisk.8.gz

	insinto /usr/share/biosdisk
	doins dosdisk.img
	doins biosdisk-mkrpm-redhat-template.spec
	doins biosdisk-mkrpm-generic-template.spec

	insinto /etc
	doins biosdisk.conf
}
