# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gai/gai-0.5.0_pre6.ebuild,v 1.1 2003/12/10 11:42:24 lordvan Exp $

MY_PV="0.5.0pre6"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="GAI, The General Applet Interface library is a library that will help applet programmers alot."
HOMEPAGE="http://gai.sourceforge.net/"
SRC_URI="mirror://sourceforge/gai/${MY_P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="opengl gnome"
DEPEND=">=x11-libs/gtk+-2.0.0
opengl? ( >=x11-libs/gtkglext-1.0.5 )
gnome? ( >=gnome-base/gnome-panel-2.0.0 )"

S=${WORKDIR}/${MY_P}

src_compile() {
	# works with just set prefix (doesn't hardcode the prefix anywhere)!
	MY_CONF="--prefix=${D}/usr "
	if [ ! "`use opengl`" ]; then
		MY_CONF="${MY_CONF} --disable-gl"
	fi
	if [ ! "`use gnome`" ]; then
		MY_CONF="${MY_CONF} --diable-gnome"
	fi
	econf ${MY_CONF} || die
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
