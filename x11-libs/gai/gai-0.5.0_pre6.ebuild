# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gai/gai-0.5.0_pre6.ebuild,v 1.2 2004/01/11 01:04:35 seemant Exp $

IUSE="opengl gnome"

MY_P=${P/_/}
DESCRIPTION="GAI, The General Applet Interface library is a library that will help applet programmers alot."
HOMEPAGE="http://gai.sourceforge.net/"
SRC_URI="mirror://sourceforge/gai/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-2.0.0
	opengl? ( >=x11-libs/gtkglext-1.0.5 )
	gnome? ( >=gnome-base/gnome-panel-2.0.0 )"

S=${WORKDIR}/${MY_P}

src_compile() {
	# works with just set prefix (doesn't hardcode the prefix anywhere)!
	econf \
		--prefix=${D}/usr \
		`use_enable opengl gl` \
		`use_enable gnome` || die

	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS COPYING.LIB ChangeLog INSTALL README \
		README.gai THANKS TODO WINDOWMANAGERS
	dohtml ${S}/docs/*
	# install examples
	cp -r ${S}/examples ${D}/usr/share/doc/${P}
}
