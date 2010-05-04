# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/sunpinyin/sunpinyin-2.0.1.ebuild,v 1.2 2010/05/04 16:06:33 matsuu Exp $

EAPI="2"
PYTHON_DEPEND="ibus? 2:2.5"
inherit confutils eutils python versionator

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"
SRC_URI="http://sunpinyin.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug ibus nls +xim"

RDEPEND="dev-db/sqlite:3
	ibus? (
		>=app-i18n/ibus-1.1
		!app-i18n/ibus-sunpinyin
	)
	nls? ( virtual/libintl )
	xim? (
		>=x11-libs/gtk+-2.12:2
		x11-libs/libX11
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	xim? ( x11-proto/xproto )"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-2)"

pkg_setup() {
	confutils_require_any ibus xim
}

src_prepare() {
	epatch "${FILESDIR}/${P}-mkdir.patch"
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable ibus) \
		$(use_enable nls) \
		$(use_enable xim) || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO || die
}

pkg_postinst() {
	use ibus && python_mod_optimize /usr/share/ibus-${PN}/setup
	if use xim ; then
		elog "To use sunpinyin with XIM, you should use the following"
		elog "in your user startup scripts such as .xinitrc or .xprofile:"
		elog "XMODIFIERS=@im=xsunpinyin ; export XMODIFIERS"
	fi
}

pkg_postrm() {
	use ibus && python_mod_cleanup /usr/share/ibus-${PN}/setup
}
