# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-1.0.0.2.ebuild,v 1.1 2005/03/09 00:08:41 vapier Exp $

inherit eutils

DESCRIPTION="Language bindings for Redland"
HOMEPAGE="http://www.redland.opensource.ac.uk/"
SRC_URI="http://www.redland.opensource.ac.uk/dist/source/${P}.tar.gz"

LICENSE="LGPL-2 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="perl python java tcltk php ruby"

DEPEND=">=dev-libs/redland-1.0.0
	dev-lang/swig
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	java? ( virtual/jdk )
	tcltk? ( dev-lang/tcl )
	php? ( dev-php/php )
	ruby? ( dev-lang/ruby )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:$(INSTALL_PROGRAM) $(TCL_PACKAGE):$(INSTALL_PROGRAM) -D $(TCL_PACKAGE):' tcl/Makefile.in
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
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
