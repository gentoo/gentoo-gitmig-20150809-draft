# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mondo-rescue/mondo-rescue-1.47.ebuild,v 1.6 2003/06/21 21:19:40 drobbins Exp $

DESCRIPTION="a nice backup tool"
SRC_URI="http://www.microwerks.net/~hugo/download/daily/${PN/-rescue/}-${PV}_20021020.tgz"
HOMEPAGE="http://www.microwerks.net/~hugo/download.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND=">=app-arch/afio-2.4.7
	>=sys-apps/mindi-0.67
	>=sys-apps/bzip2-1.0.1
	>=app-cdr/cdrtools-1.10
	>=sys-libs/ncurses-5.2
	>=sys-libs/slang-1.4.4
	>=dev-libs/lzo-1.07
	>=app-arch/lzop-1.00
	>=dev-libs/newt-0.50
	>=sys-apps/buffer-1.19
	>=sys-apps/syslinux-1.7"
S=${WORKDIR}/${PN/-rescue/}-${PV}_20021020

src_compile() {
	econf
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
}

pkg_postinst() {
	einfo
	einfo "Installation notes:"
	einfo "1) /boot must be mounted before running mondo"
	einfo "   (/etc/fstab does not automount it by default)"
	einfo "2) make a symlink \"ln -s /boot/grub/menu.lst /etc/grub.conf\""
	einfo "   as mondo wants to have a /etc/grub.conf file"
	einfo "3) when doing a system backup be sure to use"
	einfo "   \"-E ${DISTDIR}\" because otherwise"
	einfo "   all source files will be included into the backup"
	einfo
}
