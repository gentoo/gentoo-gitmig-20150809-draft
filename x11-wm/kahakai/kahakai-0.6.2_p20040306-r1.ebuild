# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/kahakai/kahakai-0.6.2_p20040306-r1.ebuild,v 1.6 2007/04/02 01:37:31 nixphoeni Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest

inherit eutils autotools

IUSE="xinerama ruby"

DESCRIPTION="A language agnostic scriptable window manager based on Waimea."
HOMEPAGE="http://kahakai.sf.net/"
#SRC_URI="mirror://sourceforge/kahakai/${P}.tar.bz2"
SRC_URI="mirror://gentoo/${P/_p/-}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-alpha ppc ~sparc x86"

RDEPEND="( x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-proto/xextproto
		xinerama? ( x11-libs/libXinerama )
		)
	|| ( x11-libs/libXft virtual/xft x11-base/xorg-x11 )
	ruby? ( || ( >=dev-lang/ruby-1.8 dev-lang/ruby-cvs ) )
	dev-lang/swig
	>=media-libs/imlib2-1.1.0
	dev-util/pkgconfig
	media-fonts/artwiz-fonts
	dev-libs/boost"

S="${WORKDIR}/${PN}"

pkg_setup() {
	if use ruby && ! built_with_use dev-lang/swig ruby; then
		die "dev-lang/swig must be built with ruby support"
	fi

	if ! built_with_use dev-lang/python tk; then
		ewarn "In order to use some of the included scripts,"
		ewarn "dev-lang/python must be built with tk support"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${P}-rubyscript-gentoo.diff
	epatch ${FILESDIR}/${P}-compilation_fix.patch
	cd ${S}
	# fixes bug #132845 (I think)
	epatch ${FILESDIR}/${P}-events.py_fix.patch
	epatch ${FILESDIR}/${P}-kastyle_fix.patch
	# fixes old m4 file problems
	epatch ${FILESDIR}/${PN}-m4_fixes.patch

	AT_M4DIR="${S}/config/m4" eautoreconf
}

src_compile() {
	econf \
		$(use_enable ruby) \
		$(use_enable xinerama) \
		--enable-hsetroot \
		--enable-kaconf || die
	emake || die

	# fix the error about redefining "None"
	sed -i -e 's:\bNone =.*::' ${S}/src/kahakai.py
}

src_install() {
	einstall || die
	cd doc
	dodoc AUTHORS NEWS COPYING README ChangeLog TODO

	exeinto /etc/X11/Sessions
	echo "/usr/bin/kahakai" > ${T}/kahakai
	doexe ${T}/kahakai
}
