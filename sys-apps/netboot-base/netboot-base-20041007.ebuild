# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netboot-base/netboot-base-20041007.ebuild,v 1.1 2004/10/07 21:00:08 vapier Exp $

inherit gcc

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

src_compile() {
	$(gcc-getCC) ${CFLAGS} src/consoletype.c -o sbin/consoletype || die
	strip --strip-unneeded sbin/consoletype
}

src_install() {
	[ "${ROOT}" == "/" ] && die "refusing to install to /"
	rm -r src
	cp -r * ${D}/
}

pkg_postinst() {
	cd ${ROOT}
	mkdir -p bin dev etc lib mnt proc sbin var
	mkdir -p var/log
	mkdir -p mnt/gentoo
	ln -s . usr
}
