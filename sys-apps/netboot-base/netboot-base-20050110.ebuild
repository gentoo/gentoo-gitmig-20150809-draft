# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netboot-base/netboot-base-20050110.ebuild,v 1.1 2005/01/10 23:40:02 gmsoft Exp $

inherit toolchain-funcs

DESCRIPTION="Baselayout for netboot systems"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~vapier/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha arm hppa mips ppc sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

pkg_setup() {
	[[ ${ROOT} = "/" ]] && die "refusing to emerge to /"
}

src_compile() {
	$(tc-getCC) ${CFLAGS} src/consoletype.c -o sbin/consoletype || die
	$(tc-getSTRIP) --strip-unneeded sbin/consoletype
}

src_install() {
	[[ ${ROOT} = "/" ]] && die "refusing to install to /"
	rm -r src
	cp -r * ${D}/
}

pkg_postinst() {
	cd "${ROOT}"
	mkdir -p bin dev etc lib mnt proc sbin var
	mkdir -p var/log
	mkdir -p mnt/gentoo
	ln -s . usr
	ln -s . share
}
