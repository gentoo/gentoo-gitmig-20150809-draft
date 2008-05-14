# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-1.0.7.1.ebuild,v 1.2 2008/05/14 17:46:03 drac Exp $

inherit eutils mono

DESCRIPTION="Language bindings for Redland"
HOMEPAGE="http://librdf.org/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="perl python java tcl php ruby mono"

RDEPEND=">=dev-libs/redland-1.0.7
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	java? ( virtual/jdk )
	tcl? ( dev-lang/tcl )
	php? ( virtual/php )
	ruby? ( dev-lang/ruby dev-ruby/log4r )
	mono? ( dev-lang/mono )"
DEPEND="${RDEPEND}
	>=dev-lang/swig-1.3.25"

src_compile() {
	econf \
		$(use_with perl) \
		$(use_with python) \
		$(use_with java) \
		$(use_with java jdk ${JAVA_HOME}) \
		$(use_with tcl tcl) \
		$(use_with php) \
		$(use_with ruby) \
		$(use_with mono ecma-cli mono) \
		--with-redland=system \
		|| die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog* NEWS README TODO
	dohtml *.html
}
