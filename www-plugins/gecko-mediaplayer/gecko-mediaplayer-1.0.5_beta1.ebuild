# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gecko-mediaplayer/gecko-mediaplayer-1.0.5_beta1.ebuild,v 1.2 2011/11/24 21:41:09 ssuominen Exp $

EAPI=4
inherit eutils multilib nsplugins

MY_P=${PN}-${PV/_beta/b}

DESCRIPTION="A browser plugin that uses GNOME MPlayer"
HOMEPAGE="http://code.google.com/p/gecko-mediaplayer/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+curl"

RDEPEND=">=dev-libs/dbus-glib-0.92
	>=dev-libs/glib-2.26:2
	dev-libs/nspr
	>=media-libs/gmtk-${PV}
	>=media-video/gnome-mplayer-${PV}[dbus]
	|| ( >=www-client/firefox-8 >=net-libs/xulrunner-1.9.2:1.9 )
	curl? ( net-misc/curl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="ChangeLog DOCS/tech/*.txt"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if has_version ">=www-client/firefox-8"; then
		epatch "${FILESDIR}"/${P}-firefox-8.x.patch

		cat <<-EOF > "${T}"/libxul.pc
		Name: libxul
		Description: Missing npapi-sdk support
		Requires: nspr
		Version: 8.0
		Cflags: -I/usr/include/firefox
		EOF
	fi
}

src_configure() {
	export PKG_CONFIG_PATH="${T}"

	econf \
		--with-plugin-dir=/usr/$(get_libdir)/${PLUGINS_DIR} \
		$(use_with curl libcurl)
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc/${PN}
}
