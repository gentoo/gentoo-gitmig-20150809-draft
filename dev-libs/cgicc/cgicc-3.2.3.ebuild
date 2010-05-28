# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cgicc/cgicc-3.2.3.ebuild,v 1.5 2010/05/28 16:54:35 ssuominen Exp $

DESCRIPTION="A C++ class library for writing CGI applications"
HOMEPAGE="http://www.cgicc.org/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc debug"

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_unpack() {
	unpack ${A}
	# docs are included in html form, no need to depend on doxygen and regenerate them
	sed -i \
		-e 's|^\(SUBDIRS = cgicc\) doc\( support $(DEMO)\)|\1\2|' \
		-e 's|^\(DIST_SUBDIRS = cgicc\) doc\(support demo contrib\)|\1\2|' \
		-e 's|\($(mkdir_p) $(distdir)/cgicc\) $(distdir)/doc\( $(distdir)/support\)|\1\2|' \
		"${S}"/Makefile.in || die "sed Makefile.in failed"
}

src_compile() {
	econf \
		--disable-demos \
		--enable-warnings \
		$(use_enable debug debug-logging) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	use doc && dohtml -r doc/html/*
	rm -rf doc
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README README.WIN THANKS
}
