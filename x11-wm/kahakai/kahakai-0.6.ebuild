# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/kahakai/kahakai-0.6.ebuild,v 1.2 2003/12/17 14:56:59 bcowan Exp $

IUSE="truetype xinerama"
S=${WORKDIR}/${P}

DESCRIPTION="A language agnostic scriptable window manager based on Waimea."
HOMEPAGE="http://kahakai.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
# 2003-12-16: karltk
# It works a lot worse than 0.5.1, which is unstable.
KEYWORDS=""

DEPEND="virtual/x11
	truetype? ( virtual/xft )
	<dev-lang/swig-1.3.18
	media-libs/imlib2
	dev-util/pkgconfig
	media-fonts/artwiz-fonts
	>=dev-libs/boost-1.30.2"

#PROVIDE="virtual/blackbox"

src_compile() {
	#./autogen.sh

	# 2003-12-16: karltk
	# Why doesn't Xrandr work?
	econf \
		--enable-hsetroot \
		--disable-xrandr \
		`use_enable python` \
		`use_enable ruby` \
		`use_enable xinerama` \
		`use_enable truetype xft` || die
	emake || die
}

src_install() {
	einstall || die
	cd doc
	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO

	exeinto /etc/X11/Sessions
	echo "/usr/bin/kahakai" > ${T}/kahakai
	doexe ${T}/kahakai

	# Nasty bug on their side!
	mv ${D}/usr/lib/kahakai/libkahakai_swig_python \
	   ${D}/usr/lib/kahakai/libkahakai_swig_python.so
}
