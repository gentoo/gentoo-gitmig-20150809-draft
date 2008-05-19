# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgadmin3/pgadmin3-1.4.3.ebuild,v 1.7 2008/05/19 19:10:18 dev-zero Exp $

inherit wxwidgets eutils autotools

KEYWORDS="alpha amd64 ppc sparc x86"

DESCRIPTION="wxWidgets GUI for PostgreSQL."
HOMEPAGE="http://www.pgadmin.org/"
SRC_URI="mirror://postgresql/pgadmin3/release/v${PV}/src/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
IUSE="debug"

DEPEND="=x11-libs/wxGTK-2.6*
	>=virtual/postgresql-base-7.4
	>=dev-libs/libxml2-2.5
	>=dev-libs/libxslt-1.1"
RDEPEND="${DEPEND}"

pkg_setup() {
	export WX_GTK_VER=2.6
	export WX_HOME=/usr
	need-wxwidgets unicode
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# --debug=yes/no for wx_config is only needed if wxGTK debug and
	# release versions are installed aside. Which is not possible
	# on Gentoo at the moment.
	sed -i \
		-e 's/--debug=[yesno]* //g' \
		acinclude.m4 || die "sed failed"
	eautoreconf
}

src_compile() {
	cd "${S}"

	# pgadmin3 inserts WX_HOME before the WX_CONFIG path below, so we have to strip "/usr" from it
	econf \
		--with-wx-config=${WX_CONFIG/\/usr} \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd "${S}"

	einstall || die "einstall failed"

	insinto /usr/share/pixmaps
	newins "${S}/src/include/images/elephant48.xpm" pgadmin3.xpm

	insinto /usr/share/pgadmin3
	newins "${S}/src/include/images/elephant48.xpm" pgadmin3.xpm

	insinto /usr/share/applications
	doins "${S}/pkg/pgadmin3.desktop"
}
