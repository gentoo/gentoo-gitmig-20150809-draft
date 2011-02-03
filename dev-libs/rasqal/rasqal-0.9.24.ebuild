# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rasqal/rasqal-0.9.24.ebuild,v 1.2 2011/02/03 19:26:10 xarthisius Exp $

EAPI=3
inherit libtool

DESCRIPTION="library that handles Resource Description Framework (RDF)"
HOMEPAGE="http://librdf.org/rasqal/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos"
IUSE="gmp pcre static-libs test xml"

RDEPEND="media-libs/raptor:2
	pcre? ( dev-libs/libpcre )
	xml? ( dev-libs/libxml2 )
	!gmp? ( dev-libs/mpfr )
	gmp? ( dev-libs/gmp )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	test? ( dev-perl/XML-DOM )"

src_prepare() {
	elibtoolize
}

src_configure() {
	local regex=posix
	local decimal=mpfr

	use pcre && regex=pcre
	use gmp && decimal=gmp

	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable pcre) \
		$(use_enable xml xml2) \
		--with-regex-library=${regex} \
		--with-decimal=${decimal} \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
	dohtml {NEWS,README,RELEASE}.html
	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
