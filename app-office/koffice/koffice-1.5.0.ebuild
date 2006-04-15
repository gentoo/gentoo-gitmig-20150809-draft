# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.5.0.ebuild,v 1.3 2006/04/15 18:12:16 kingtaco Exp $

inherit kde

RV="1.5.0"
MY_P="koffice-${RV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="An integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
SRC_URI="mirror://kde/stable/koffice-${PV}/src/${P}.tar.bz2"
#SRC_URI="mirror://kde/unstable/koffice-${PV/_/-}/src/${MY_P}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc mysql opengl postgres"

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
	virtual/python
	dev-lang/ruby
	>=media-libs/lcms-1.14-r1
	>=app-text/libwpd-0.8.2
	opengl? ( virtual/opengl virtual/glu )"

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

src_compile() {
	local myconf="$(use_enable mysql) $(use_enable postgres pgsql) $(use_enable opengl gl)"

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
