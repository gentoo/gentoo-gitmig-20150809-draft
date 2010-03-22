# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/biosdisk/biosdisk-0.65.ebuild,v 1.4 2010/03/22 18:14:42 jlec Exp $

DESCRIPTION="A script that creates floppy boot images to flash Dell BIOSes"
HOMEPAGE="http://linux.dell.com/projects.shtml#biosdisk"
SRC_URI="http://linux.dell.com/biosdisk/permalink/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="
	|| ( app-text/unix2dos >=app-text/dos2unix-5.0 )
	sys-boot/syslinux"

src_install() {
	dosbin biosdisk blconf || die

	dodoc AUTHORS README README.dosdisk TODO VERSION || die
	doman biosdisk.8.gz || die

	insinto /usr/share/biosdisk
	doins dosdisk.img biosdisk-mkrpm-{redhat,generic}-template.spec || die

	insinto /etc
	doins biosdisk.conf || die
}
