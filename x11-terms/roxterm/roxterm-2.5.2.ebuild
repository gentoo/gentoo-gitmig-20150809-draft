# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/roxterm/roxterm-2.5.2.ebuild,v 1.2 2012/03/08 15:09:27 ssuominen Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
inherit gnome2-utils python

DESCRIPTION="A terminal emulator designed to integrate with the ROX environment"
HOMEPAGE="http://roxterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/roxterm/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.16
	x11-libs/gtk+:3
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/vte:2.90"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/pkgconfig
	dev-python/lockfile
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	nls? ( app-text/po4a sys-devel/gettext )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs 2 mscript.py

	# build system is crap
	sed -i -e 's:TerminalEmulator:System;&:' roxterm.desktop || die
	sed -i -e '/ctx.install_doc/s:COPYING ::' mscript.py || die
	sed -i -e "/CFLAGS/s:-O2 -g:${CFLAGS}:" {maitch,mscript}.py || die
	sed -i \
		-e "/LDFLAGS/s:'':'${LDFLAGS}':" \
		-e 's:--mode=link:--mode=link --tag=CC:' \
		maitch.py || die
}

src_configure() {
	local myconf=( --prefix=/usr --docdir=/usr/share/doc/${PF} --destdir="${D}" )
	use nls || myconf+=( --disable-gettext --disable-po4a --disable-translations )
	./mscript.py configure "${myconf[@]}"
}

src_compile() { ./mscript.py build; }
src_install() { ./mscript.py install; }
pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
