# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/postler/postler-0.1.1.ebuild,v 1.1 2011/03/21 07:59:41 angelos Exp $

EAPI=3

inherit gnome2-utils python waf-utils

DESCRIPTION="A super sexy, ultra simple desktop mail client built in vala"
HOMEPAGE="https://launchpad.net/postler"
SRC_URI="http://git.xfce.org/apps/${PN}/snapshot/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ayatana"

RDEPEND=">=dev-libs/glib-2.26:2
	dev-libs/libunique
	dev-libs/openssl
	mail-mta/msmtp
	media-libs/libcanberra
	net-libs/webkit-gtk
	>=x11-libs/gtk+-2.18:2
	x11-libs/libnotify
	ayatana? ( dev-libs/libindicate )"
DEPEND="${RDEPEND}
	|| ( dev-lang/python:2.6 dev-lang/python:2.7 )
	dev-lang/vala:0.10
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	VALAC="$(type -p valac-0.10)" \
		   waf-utils_src_configure \
		   --disable-docs \
		   $(use_enable ayatana libindicate)
}

src_install() {
	waf-utils_src_install
	dodoc ChangeLog README || die "dodoc failed"
}

src_test() {
	"${WAF_BINARY}" check || die "check failed"
}

pkg_preinst() { gnome2_icon_savelist ; }
pkg_postinst() { gnome2_icon_cache_update ; }
pkg_postrm() { gnome2_icon_cache_update ; }
