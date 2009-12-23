# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uzbl/uzbl-0_pre20091222.ebuild,v 1.1 2009/12/23 08:08:28 wired Exp $

EAPI="2"

inherit base

MY_PV=${PV/*_pre}
MY_PV=${MY_PV:0:4}.${MY_PV:4:2}.${MY_PV:6}

DESCRIPTION="A keyboard controlled (modal vim-like bindings, or with modifierkeys) browser based on Webkit."
HOMEPAGE="http://www.uzbl.org"
SRC_URI="http://github.com/Dieterbe/${PN}/tarball/${MY_PV} -> ${P}.tar.gz"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+browser helpers +tabbed"

COMMON_DEPEND="
	>=dev-libs/icu-4.0.1
	>=net-libs/libsoup-2.24
	>=net-libs/webkit-gtk-1.1.15
	>=x11-libs/gtk+-2.14
"

DEPEND="
	>=dev-util/pkgconfig-0.19
	${COMMON_DEPEND}
"

RDEPEND="
	${COMMON_DEPEND}
	x11-misc/xdg-utils
	browser? (
		x11-misc/xclip
	)
	helpers? (
		dev-lang/perl
		dev-perl/gtk2-perl
		dev-python/pygtk
		dev-python/pygobject
		gnome-extra/zenity
		net-misc/socat
		x11-libs/pango
		x11-misc/dmenu
		x11-misc/xclip
	)
"

pkg_setup() {
	if ! use helpers; then
		elog "uzbl's extra scripts use various optional applications:"
		elog
		elog "   dev-lang/perl"
		elog "   dev-perl/gtk2-perl"
		elog "   dev-python/pygtk"
		elog "   dev-python/pygobject"
		elog "   gnome-extra/zenity"
		elog "   net-misc/socat"
		elog "   x11-libs/pango"
		elog "   x11-misc/dmenu"
		elog "   x11-misc/xclip"
		elog
		elog "Make sure you emerge the ones you need manually."
		elog "You may also activate the *helpers* USE flag to"
		elog "install all of them automatically."
	else
		einfo "You have enabled the *helpers* USE flag that installs"
		einfo "various optional applications used by uzbl's extra scripts."
	fi

	if use tabbed && ! use browser; then
		ewarn
		ewarn "You enabled the *tabbed* USE flag but not *browser*."
		ewarn "*tabbed* depends on *browser*, so it will be disabled."
		ewarn
		ebeep 3
	fi
}

src_prepare() {
	cd "${WORKDIR}"/Dieterbe-uzbl-*
	S=$(pwd)

	# patch Makefile to make it more sane
	epatch "${FILESDIR}"/"${PN}"-makefile-cleanup.patch

	# adjust path in default config file to /usr/share
	sed -i "s:/usr/local/share/uzbl:/usr/share/uzbl:g" \
		examples/config/uzbl/config ||
		die "config path sed failed"
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	local targets="install-uzbl-core"
	use browser && targets="${targets} install-uzbl-browser"
	use browser && use tabbed && targets="${targets} install-uzbl-tabbed"

	emake DESTDIR="${D}" PREFIX="/usr" ${targets} || die "Installation failed"

	# Install the docs in /usr/share/doc.
	dodoc AUTHORS README docs/* || die "docs install failed"
}
