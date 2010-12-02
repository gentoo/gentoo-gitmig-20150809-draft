# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cabocha/cabocha-0.60_pre4.ebuild,v 1.2 2010/12/02 01:17:51 flameeyes Exp $

inherit autotools eutils multilib

MY_P="${P/_}"
DESCRIPTION="Yet Another Japanese Dependency Structure Analyzer"
HOMEPAGE="http://chasen.org/~taku/software/cabocha/"
SRC_URI="mirror://sourceforge/cabocha/${MY_P}.tar.bz2"

LICENSE="|| ( LGPL-2.1 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#IUSE="java perl python ruby unicode"
IUSE="unicode"

DEPEND="app-text/crf++
	app-text/mecab"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/^modeldir/s|lib|$(get_libdir)|" model/Makefile.am || die
	eautoreconf
}

src_compile() {
	local myconf
	use unicode && myconf="${myconf} --with-charset=UTF8"

	econf ${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README TODO
}
