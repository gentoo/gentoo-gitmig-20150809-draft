# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rasqal/rasqal-0.9.15.ebuild,v 1.5 2008/05/12 09:29:01 aballier Exp $

inherit libtool

DESCRIPTION="library that handles Resource Description Framework (RDF)"
HOMEPAGE="http://librdf.org/rasqal"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="LGPL-2.1 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug gmp pcre test xml"

RDEPEND=">=media-libs/raptor-1.4.16
	pcre? ( dev-libs/libpcre )
	xml? ( dev-libs/libxml2 )
	!gmp? ( dev-libs/mpfr )
	gmp? ( dev-libs/gmp )
	debug? ( >=dev-libs/dmalloc-5.5.2-r2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	test? ( dev-perl/XML-DOM )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	elibtoolize
}

src_compile() {
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

	econf $(use_enable pcre) $(use_enable xml xml2) $(use_with debug dmalloc) \
		$(use_enable debug maintainer-mode) --with-regex-library=${regex} \
		--with-decimal=${decimal} --with-raptor=system

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog* NEWS README
}
