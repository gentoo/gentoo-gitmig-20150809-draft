# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxmozilla/wxmozilla-0.5.3.ebuild,v 1.1 2004/12/11 17:32:21 kloeri Exp $

inherit eutils libtool

IUSE="python doc"

DESCRIPTION="Mozilla widget for wxWindows"
SRC_URI="mirror://sourceforge/wxmozilla/${P}.tar.gz"
HOMEPAGE="http://wxmozilla.sourceforge.net/"

DEPEND=">=mozilla-1.3
	python? ( dev-lang/python >=dev-python/wxpython-2.4 )
	>=x11-libs/wxGTK-2.4"

SLOT="0"
LICENSE="wxWinLL-3"
KEYWORDS="~x86"

pkg_setup() {
	# make sure gtk{1,2} setting of Mozilla and wxGTK is same
	if built_with_use net-www/mozilla gtk2; then
		tk_mozilla="gtk2"
	else
		tk_mozilla="gtk1"
	fi
	if built_with_use x11-libs/wxGTK gtk2; then
		tk_wxgtk="gtk2"
	else
		tk_wxgtk="gtk1"
	fi

	if [ $tk_mozilla != $tk_wxgtk ]; then
		eerror "You need x11-libs/wxGTK and net-www/mozilla compiled with same GTK+ version."
		eerror "Emerge both either with or without 'gtk2' in your USE flags."
		eerror "wxGTK toolkit: $tk_wxgtk"
		eerror "Mozilla toolkit: $tk_mozilla"
		die "wxGTK and Mozilla must use same major GTK+ version"
	fi
}

src_compile() {
	elibtoolize
	econf `use_enable python` || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"

	if use doc; then
		insinto /usr/share/doc/${PF}
		exeinto /usr/share/doc/${PF}
		doins README
		newins demo/main.cpp example.cpp
		doexe demo/wxMozillaDemo
		doins wxPython/demo/*.py
	fi
}
