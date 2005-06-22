# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.4.0-r1.ebuild,v 1.1 2005/06/22 13:19:08 greg_g Exp $

inherit kde eutils

DESCRIPTION="An integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
SRC_URI="mirror://kde/stable/koffice-1.4/src/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc javascript mysql postgres"

RDEPEND=">=media-gfx/imagemagick-5.5.2
	>=app-text/wv2-0.1.9
	>=media-libs/freetype-2
	media-libs/fontconfig
	media-libs/libart_lgpl
	dev-libs/libxml2
	dev-libs/libxslt
	sys-libs/readline
	mysql? ( dev-db/mysql )
	postgres? ( dev-libs/libpqxx )
	dev-lang/python
	media-libs/lcms
	javascript? ( kde-base/kjsembed )
	!dev-db/kexi"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig"

# add blockers on split packages derived from this one
for x in $(get-child-packages ${CATEGORY}/${PN}); do
	DEPEND="${DEPEND} !${x}"
	RDEPEND="${RDEPEND} !${x}"
done

need-kde 3.3

# TODO: kword sql plugin needs Qt compiled with sql support
# the dependency on python is needed for scripting support in kexi
# and for kivio/kiviopart/kiviosdk.

src_unpack() {
	kde_src_unpack

	# Fix problem when saving from koshell. Applied for 1.4.1.
	epatch "${FILESDIR}/${P}-save.patch"
}

src_compile() {
	local myconf="$(use_enable mysql) $(use_enable postgres pgsql)"

	kde_src_compile
	if use doc; then
		make apidox || die
	fi
}

src_install() {
	kde_src_install
	if use doc; then
		make DESTDIR="${D}" install-apidox || die
	fi

	dodoc changes-*
}
