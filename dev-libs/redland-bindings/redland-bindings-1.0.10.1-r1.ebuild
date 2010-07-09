# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-1.0.10.1-r1.ebuild,v 1.3 2010/07/09 18:57:55 mabi Exp $

EAPI=2
inherit multilib

DESCRIPTION="Language bindings for Redland"
HOMEPAGE="http://librdf.org/bindings/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos"
IUSE="perl python php ruby"

RDEPEND=">=dev-libs/redland-1.0.10-r1
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	php? ( dev-lang/php )
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
	# --with-python-ldflags line can be dropped from next release
	# as it's been fixed in trunk
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
	emake DESTDIR="${D}" INSTALLDIRS=vendor install || die

	if use perl; then
		find "${D}" -type f -name perllocal.pod -delete
		find "${D}" -depth -mindepth 1 -type d -empty -delete
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO
	dohtml {NEWS,README,RELEASE,TODO}.html
}
