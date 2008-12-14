# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/dox/dox-1.1.ebuild,v 1.22 2008/12/14 00:06:46 flameeyes Exp $

EAPI=1

inherit qt3 eutils

DESCRIPTION="graphical documentation browser for Unix/X11"
SRC_URI="mirror://berlios/dox/${P}.tar.gz"
HOMEPAGE="http://dox.berlios.de/"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 ppc"

DEPEND="www-misc/htdig
	x11-libs/qt:3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:/opt/www/htdig/bin/htdig:/usr/bin/htdig:g' \
		-e 's:/opt/www/htdig/bin/htmerge:/usr/bin/htmerge:g' \
		-e 's:/opt/www/cgi-bin/htsearch:/usr/bin/htsearch:g' \
		-e 's:qmake:${QTDIR}/bin/qmake:g' configure || die "sed failed"

	epatch "${FILESDIR}/${P}+gcc-4.3.patch"
}

src_compile() {
	econf || die
	emake all || die
	mv stl/stl.toc stl/STL.toc
	mv stl/stl.index stl/STL.index
	mv data/perl.toc data/Perl.toc
}

src_install() {
	PREFIX="/usr/share/dox"
	into /usr
	dobin dox/dox man2html/dox-man2html info2html/dox-info2html tags2dox/dox-tags2dox htdig/dox-htdig
	insinto ${PREFIX}/scripts
	insopts -m 0755
	doins pydoc2html/dox_pydoc.py pydoc2html/dox_inspect.py
	insinto ${PREFIX}/htdig
	doins data/wrapper.html data/nomatch.html  data/syntax.html data/star.png data/star_blank.png data/bad_words
	insinto ${PREFIX}/html/libc
	doins libc/*.html
	insinto ${PREFIX}/tocs
	doins libc/libc.toc stl/STL.toc data/Perl.toc
	insinto ${PREFIX}/indices
	doins libc/libc.index stl/STL.index
	insinto ${PREFIX}/html/stl
	doins stl/*.html  stl/*.gif
	doman data/dox.1 data/dox.5 data/dox-man2html.1 data/dox-info2html.1 data/dox-tags2dox.1 data/dox-htdig.1
}
