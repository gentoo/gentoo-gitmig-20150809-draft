# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cgicc/cgicc-3.2.1.ebuild,v 1.4 2004/03/14 12:14:29 mr_bones_ Exp $

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="A C++ class library for writing CGI applications"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.cgicc.org"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# docs are included in html form, no need to depend on doxygen and regenerate them
	mv Makefile.in Makefile.in.orig
	sed -e 's|^SUBDIRS = cgicc doc support $(DEMO)|SUBDIRS = cgicc support $(DEMO)|' \
		-e 's|^DIST_SUBDIRS = cgicc doc support demo contrib|DIST_SUBDIRS = cgicc support demo contrib|' \
		-e 's|$(mkinstalldirs) $(distdir)/cgicc $(distdir)/doc $(distdir)/support|$(mkinstalldirs) $(distdir)/cgicc $(distdir)/support|' \
		Makefile.in.orig > Makefile.in
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dohtml -r doc/html/*
	rm -rf doc
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING COPYING.DOC COPYING.LIB INSTALL NEWS README README.WIN THANKS
}
