# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/djview4/djview4-4.5-r1.ebuild,v 1.6 2010/06/26 17:34:38 nixnut Exp $

EAPI=2

inherit eutils autotools versionator qt4 toolchain-funcs multilib nsplugins fdo-mime flag-o-matic

MY_P=${PN}-$(replace_version_separator 2 '-')

DESCRIPTION="Portable DjVu viewer using Qt4"
HOMEPAGE="http://djvu.sourceforge.net/djview4.html"
SRC_URI="mirror://sourceforge/djvu/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 x86"
IUSE="debug nsplugin"

RDEPEND="
	>=app-text/djvu-3.5.22-r1
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nsplugin? ( dev-libs/glib:2 )"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_prepare() {
	# Force XEmbed instead of Xt-based mainloop (disable Xt autodep)
	sed -e 's:\(ac_xt=\)yes:\1no:' -i configure* || die
	sed 's/AC_CXX_OPTIMIZE/OPTS=;AC_SUBST(OPTS)/' -i configure.ac || die #263688
	epatch "${FILESDIR}/${P}-libtool.patch"
	rm aclocal.m4 config/{libtool.m4,ltmain.sh,install-sh}
	AT_M4DIR="config" eautoreconf
}

src_configure() {
	# See config/acinclude.m4
	use debug || append-cppflags "-DNDEBUG"

	# QTDIR is needed because of kde3
	QTDIR=/usr \
	econf \
		--with-x \
		$(use_enable nsplugin nsdejavu) \
		--disable-desktopfiles
}

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" \
		plugindir=/usr/$(get_libdir)/${PLUGINS_DIR} \
			install || die "emake install failed"

	dodoc README TODO NEWS || die "dodoc failed"

	cd desktopfiles
	insinto /usr/share/icons/hicolor/32x32/apps
	newins hi32-djview4.png djvulibre-djview4.png
	insinto /usr/share/icons/hicolor/scalable/apps
	newins djview.svg djvulibre-djview4.svg
	domenu djvulibre-djview4.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
