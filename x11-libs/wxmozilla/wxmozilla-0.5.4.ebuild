# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxmozilla/wxmozilla-0.5.4.ebuild,v 1.1 2005/06/04 13:43:22 fserb Exp $

inherit eutils libtool

IUSE="python doc"

DESCRIPTION="Mozilla widget for wxWindows"
SRC_URI="mirror://sourceforge/wxmozilla/${P}.tar.gz"
HOMEPAGE="http://wxmozilla.sourceforge.net/"

DEPEND=">=www-client/mozilla-1.3
	python? ( dev-lang/python >=dev-python/wxpython-2.4 )
	>=x11-libs/wxGTK-2.4"

SLOT="0"
LICENSE="wxWinLL-3"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/wxmozilla-wxpy-2.4.patch
}

pkg_setup() {
	# make sure gtk{1,2} setting of Mozilla and wxGTK is same
	if built_with_use www-client/mozilla gtk2; then
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
		eerror "You need x11-libs/wxGTK and www-client/mozilla compiled with same GTK+ version."
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
		dodoc README
		newdoc demo/main.cpp example.cpp
		if use python; then
			dodoc wxPython/demo/*.py
		fi
	fi
}
