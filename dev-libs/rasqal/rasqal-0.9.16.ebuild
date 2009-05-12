# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rasqal/rasqal-0.9.16.ebuild,v 1.6 2009/05/12 14:20:32 fmccor Exp $

EAPI=2
inherit libtool

DESCRIPTION="library that handles Resource Description Framework (RDF)"
HOMEPAGE="http://librdf.org/rasqal"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE="gmp pcre test xml"

RDEPEND=">=media-libs/raptor-1.4.17
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
	local regex
	local decimal

	if use pcre; then
		regex="pcre"
	else
		regex="posix"
	fi

	if use gmp; then
		decimal="gmp"
	else
		decimal="mpfr"
	fi

	econf \
		$(use_enable pcre) \
		$(use_enable xml xml2) \
		--with-regex-library=${regex} \
		--with-decimal=${decimal} \
		--with-raptor=system
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog* NEWS README
}
