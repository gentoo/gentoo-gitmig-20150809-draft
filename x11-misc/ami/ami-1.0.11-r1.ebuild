# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ami/ami-1.0.11-r1.ebuild,v 1.3 2003/09/05 23:18:18 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Korean IMS Ami"
SRC_URI="http://www.kr.freebsd.org/~hwang/ami/${P}.tar.gz
	http://www.kr.freebsd.org/~hwang/ami/hanja.dic.gz
	ftp://ftp.nnongae.com/pub/gentoo/${P}.patch"
HOMEPAGE="http://www.kr.freebsd.org/~hwang/ami/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/gdk-pixbuf-0.7.0"

src_unpack() {
	unpack ${A}
	patch -p0 < ${DISTDIR}/${P}.patch || die
}

src_compile() {
	local config

	use gnome && config="--enable-gnome-applet"

	econf --with-hangul-keyboard=2

	emake || die

	cd ${S}/hanjadic
	emake || die
}

src_install() {
	einstall || die

	gzip -d -c ${DISTDIR}/hanja.dic.gz > ${D}/usr/share/ami/hanja.dic

	dobin ${S}/hanjadic/hanja-hwp2ami
	dodoc AUTHORS COPYING* ChangeLog INSTALL README README.en NEWS THANKS
}
