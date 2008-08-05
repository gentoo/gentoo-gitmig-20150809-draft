# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-1.0.8.1.ebuild,v 1.1 2008/08/05 14:56:27 aballier Exp $

inherit eutils multilib

DESCRIPTION="Language bindings for Redland"
HOMEPAGE="http://librdf.org/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="perl python php ruby"

RDEPEND=">=dev-libs/redland-1.0.8
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	php? ( virtual/php )
	ruby? ( dev-lang/ruby dev-ruby/log4r )"
DEPEND="${RDEPEND}
	>=dev-lang/swig-1.3.25"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Multilib fix
	sed -i -e "s:lib/python:$(get_libdir)/python:" configure
}

src_compile() {
	econf \
		$(use_with perl) \
		$(use_with python) \
		$(use_with php) \
		$(use_with ruby) \
		--with-redland=system \
		|| die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog* NEWS README TODO
	dohtml *.html
}
