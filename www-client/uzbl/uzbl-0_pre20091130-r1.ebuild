# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uzbl/uzbl-0_pre20091130-r1.ebuild,v 1.1 2009/12/05 16:19:54 wired Exp $

EAPI="2"

inherit base

MY_PV=${PV/*_pre}
MY_PV=${MY_PV:0:4}.${MY_PV:4:2}.${MY_PV:6}

DESCRIPTION="A keyboard controlled (modal vim-like bindings, or with modifierkeys) browser based on Webkit."
HOMEPAGE="http://www.uzbl.org"
SRC_URI="http://github.com/Dieterbe/${PN}/tarball/${MY_PV} -> ${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+browser helpers +tabbed"

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
		dev-lang/perl
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
	ewarn "Since the helpers are growing into a fine list I've decided"
	ewarn "to keep them under a single USE flag to avoid a USE hell".
	ewarn "You can always install the ones you need manually if you don't"
	ewarn "need them all."
	ewarn

	if use tabbed && ! use browser; then
		ewarn "You enabled 'tabbed' but not 'browser' which is required by"
		ewarn "'tabbed'. uzbl-browser will be installed anyway to fulfill the"
		ewarn "dependency."
		ewarn
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
	if use tabbed; then
		emake DESTDIR="${D}" PREFIX="/usr" install || die "Installation failed"
	else if use browser; then
			emake DESTDIR="${D}" PREFIX="/usr" install-uzbl-browser || die "Installation failed"
		else
			emake DESTDIR="${D}" PREFIX="/usr" install-uzbl-core || die "Installation failed"
		fi
	fi

	# Move the docs to /usr/share/doc instead.
	dodoc AUTHORS README docs/*
}
