# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-1.0.8.1.ebuild,v 1.2 2009/05/12 09:00:31 ssuominen Exp $

inherit multilib

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
	dev-lang/swig
	sys-apps/sed"

src_prepare() {
	sed -i -e "s:lib/python:$(get_libdir)/python:" \
		configure || die "sed failed"
}

src_configure() {
	econf \
		$(use_with perl) \
		$(use_with python) \
		$(use_with php) \
		$(use_with ruby) \
		--with-redland=system
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog* NEWS README TODO
	dohtml *.html
}
