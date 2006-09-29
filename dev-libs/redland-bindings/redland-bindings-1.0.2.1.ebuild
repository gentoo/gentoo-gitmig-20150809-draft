# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-1.0.2.1.ebuild,v 1.4 2006/09/29 10:18:35 vapier Exp $

inherit eutils mono

DESCRIPTION="Language bindings for Redland"
HOMEPAGE="http://librdf.org/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="perl python java tcltk php ruby mono"

DEPEND=">=dev-libs/redland-1.0.2
	>=dev-lang/swig-1.3.25
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	java? ( virtual/jdk )
	tcltk? ( dev-lang/tcl )
	php? ( virtual/php )
	ruby? ( dev-lang/ruby dev-ruby/log4r )
	mono? ( dev-lang/mono )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(INSTALL_PROGRAM) $(TCL_PACKAGE):$(INSTALL_PROGRAM) -D $(TCL_PACKAGE):' tcl/Makefile.in
	epatch "${FILESDIR}"/${PN}-1.0.0.2-configure.patch
	epatch "${FILESDIR}"/${PN}-1.0.0.2-DESTDIR.patch
	epatch "${FILESDIR}"/${PN}-1.0.0.2-swig-update.patch
}

src_compile() {
	econf \
		$(use_with perl) \
		$(use_with python) \
		$(use_with java) \
		$(use_with java jdk ${JAVA_HOME}) \
		$(use_with tcltk tcl) \
		$(use_with php) \
		$(use_with ruby) \
		$(use_with mono ecma-cli mono) \
		--with-redland=system \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
