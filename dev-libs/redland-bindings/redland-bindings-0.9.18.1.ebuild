# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-0.9.18.1.ebuild,v 1.2 2004/08/31 02:09:31 vapier Exp $

inherit eutils

DESCRIPTION="Language bindings for Redland"
HOMEPAGE="http://www.redland.opensource.ac.uk/"
SRC_URI="http://www.redland.opensource.ac.uk/dist/source/${P}.tar.gz"

LICENSE="LGPL-2 MPL-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="perl python java tcltk php ruby"

DEPEND=">=dev-libs/redland-0.9.18
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
	epatch ${FILESDIR}/${PV}-configure.patch
	sed -i 's:$(INSTALL_PROGRAM) $(TCL_PACKAGE):$(INSTALL_PROGRAM) -D $(TCL_PACKAGE):' tcl/Makefile.in
}

src_compile() {
	econf \
		`use_with perl` \
		`use_with python` \
		`use_with java` \
		`use_with java jdk ${JAVA_HOME}` \
		`use_with tcltk tcl` \
		`use_with php` \
		`use_with ruby` \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
