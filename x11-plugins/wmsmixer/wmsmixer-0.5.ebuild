# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsmixer/wmsmixer-0.5.ebuild,v 1.4 2003/10/16 16:10:23 drobbins Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="fork of wmmixer adding scrollwheel support and other features"
HOMEPAGE="http://www.hibernaculum.net/wmsmixer.html"
SRC_URI="http://www.hibernaculum.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/gcc3.diff || die "patch failed"

}

src_compile() {

	xmkmf || die "xmkmf failed"

	patch -p0 < ${FILESDIR}/makefile.diff

	make || die "parallel make failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

}
