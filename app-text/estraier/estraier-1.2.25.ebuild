# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/estraier/estraier-1.2.25.ebuild,v 1.5 2006/04/22 14:57:24 hattya Exp $

IUSE="debug chasen kakasi mecab zlib"

DESCRIPTION="a personal full-text search system"
HOMEPAGE="http://estraier.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc ~sparc"
SLOT="0"

DEPEND=">=dev-db/qdbm-1.8.16
	zlib? ( sys-libs/zlib )
	|| (
		chasen? ( app-text/chasen )
		mecab?  ( app-text/mecab )
		kakasi? ( app-i18n/kakasi )
	)"

src_compile() {

	local myconf=

	if use chasen; then
		myconf="`use_enable chasen`"

	elif use mecab; then
		myconf="`use_enable mecab`"

	elif use kakasi; then
		myconf="`use_enable kakasi`"

	else
		myconf="--enable-cjkuni"

	fi

	econf \
		`use_enable zlib` \
		`use_enable debug` \
		--enable-dlfilter \
		--enable-regex \
		--with-sysqdbm \
		$myconf \
		|| die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc README* ChangeLog
	dohtml *.html

	rm -f ${D}/usr/share/${PN}/{COPYING,ChangeLog}
	rm -f ${D}/usr/share/${PN}/*.html

}
