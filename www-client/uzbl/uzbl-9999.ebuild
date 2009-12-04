# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uzbl/uzbl-9999.ebuild,v 1.3 2009/12/04 14:29:05 wired Exp $

EAPI="2"

inherit base git

DESCRIPTION="A keyboard controlled (modal vim-like bindings, or with modifierkeys) browser based on Webkit."
HOMEPAGE="http://www.uzbl.org"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Dieterbe/uzbl.git"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS=""
IUSE="experimental helpers"

COMMON_DEPEND="
	>=net-libs/webkit-gtk-1.1.15
	>=net-libs/libsoup-2.24
	>=x11-libs/gtk+-2.14
	>=dev-libs/icu-4.0.1
"

DEPEND="
	>=dev-util/pkgconfig-0.19
	${COMMON_DEPEND}
"

RDEPEND="
	${COMMON_DEPEND}
	helpers? (
		x11-misc/dmenu
		net-misc/socat
		x11-misc/xclip
		gnome-extra/zenity
	)
"

pkg_setup() {
	use experimental && EGIT_BRANCH="experimental"
}

src_prepare() {
	git_src_prepare

	# patch Makefile to make it more sane
	epatch "${FILESDIR}"/"${P}"-makefile-cleanup.patch

	# adjust path in default config file to /usr/share
	sed -i "s:/usr/local/share/uzbl:/usr/share/uzbl:g" \
		examples/config/uzbl/config ||
		die "config path sed failed"
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "Installation failed"

	# Move the docs to /usr/share/doc instead.
	dodoc AUTHORS README docs/*
}
