# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-es/manpages-es-1.28.ebuild,v 1.9 2005/04/14 12:46:16 ferdy Exp $

S1=${WORKDIR}/man-pages-es-1.28
S2=${WORKDIR}/man-pages-es-extra-0.8a

DESCRIPTION="A somewhat comprehensive collection of Linux spanish man page translations"
SRC_URI="http://ditec.um.es/~piernas/manpages-es/man-pages-es-1.28.tar.gz
	http://ditec.um.es/~piernas/manpages-es/man-pages-es-extra-0.8a.tar.gz"
HOMEPAGE="http://ditec.um.es/~piernas/manpages-es/index.html"
IUSE=""
KEYWORDS="x86 alpha hppa amd64"

DEPEND=""
RDEPEND="sys-apps/man"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	cd ${S1}
	make gz || die
	cd ${S2}
	make gz || die
}

src_install() {
	cd ${S1}
	make MANDIR=${D}/usr/share/man/es install  || die
	cd ${S2}
	make MANDIR=${D}/usr/share/man/es install  || die
}

