# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.4.2-r8.ebuild,v 1.2 2006/11/30 20:39:45 corsair Exp $

inherit kde

DESCRIPTION="An integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
SRC_URI="mirror://kde/stable/koffice-${PV}/src/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ppc64 ~sparc ~x86"
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
	>=media-libs/lcms-1.12
	!ia64? ( !alpha? ( !sparc? ( javascript? ( kde-base/kjsembed ) ) ) )
	>=app-text/libwpd-0.8.2"

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

PATCHES="${FILESDIR}/kspread-1.4.2-gcc41.patch
	${FILESDIR}/kexi-1.4.2-gcc41.patch
	${FILESDIR}/krita-1.4.2-gcc41.patch
	${FILESDIR}/post-1.3-koffice-CAN-2005-3193.diff
	${FILESDIR}/koffice-ole-filter.patch"

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
