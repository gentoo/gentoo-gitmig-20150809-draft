# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxmozilla/wxmozilla-0.5.6.ebuild,v 1.1 2006/04/26 19:21:21 fserb Exp $

inherit eutils libtool flag-o-matic

# firefox support is disabled until it compiles.
IUSE="python doc"

DESCRIPTION="Mozilla widget for wxWindows"
SRC_URI="mirror://sourceforge/wxmozilla/${P}.tar.gz"
HOMEPAGE="http://wxmozilla.sourceforge.net/"

#	!firefox? ( >=www-client/mozilla-1.3 )
#	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
DEPEND=">=www-client/mozilla-1.3
	python? ( dev-lang/python >=dev-python/wxpython-2.6.3 )
	>=x11-libs/wxGTK-2.4"

SLOT="0"
LICENSE="wxWinLL-3"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/wxmozilla-wxpy-2.4.patch
}

src_compile() {
	elibtoolize
	#append-flags "-DMOZILLA_INTERNAL_API"
	# `use_enable firefox`
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
