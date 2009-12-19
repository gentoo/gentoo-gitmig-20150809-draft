# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-1.0.10.1.ebuild,v 1.2 2009/12/19 19:10:55 ssuominen Exp $

EAPI=2
inherit multilib

DESCRIPTION="Language bindings for Redland"
HOMEPAGE="http://librdf.org/bindings/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="perl python php ruby"

RDEPEND=">=dev-libs/redland-1.0.10-r1
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	php? ( virtual/php )
	ruby? ( dev-lang/ruby dev-ruby/log4r )"
DEPEND="${RDEPEND}
	dev-lang/swig
	sys-apps/sed
	perl? ( sys-apps/findutils )"

src_prepare() {
	sed -i \
		-e "s:lib/python:$(get_libdir)/python:" \
		configure || die
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with perl) \
		$(use_with python) \
		--with-python-ldflags="-shared -lrdf" \
		$(use_with php) \
		$(use_with ruby) \
		--with-redland=system
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use perl; then
		find "${D}" -type f -name perllocal.pod -delete
		find "${D}" -depth -mindepth 1 -type d -empty -delete
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO
	dohtml {NEWS,README,RELEASE,TODO}.html
}
