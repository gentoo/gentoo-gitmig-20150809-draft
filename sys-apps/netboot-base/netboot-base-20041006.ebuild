# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netboot-base/netboot-base-20041006.ebuild,v 1.2 2004/10/06 21:19:31 vapier Exp $

DESCRIPTION="Baselayout for netboot systems"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~vapier/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm hppa x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

pkg_setup() {
	[ "${ROOT}" == "/" ] && die "refusing to emerge to /"
}

src_install() {
	[ "${ROOT}" == "/" ] && die "refusing to install to /"
	cp -r * ${D}/
}

pkg_postinst() {
	cd ${ROOT}
	mkdir -p bin dev etc lib mnt proc sbin var
	mkdir -p var/log
	mkdir -p mnt/gentoo
}
