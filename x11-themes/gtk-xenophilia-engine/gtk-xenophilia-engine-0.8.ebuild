# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-xenophilia-engine/gtk-xenophilia-engine-0.8.ebuild,v 1.5 2002/10/24 23:23:45 blizzy Exp $

MY_P=${P/gtk-/}
MY_P=${MY_P/-engine/}
S=${WORKDIR}/${MY_P/x/X}
DESCRIPTION="Gtk+-2 engine, xfce"
SRC_URI="http://themes.freshmeat.net/redir/xenophilia/24574/url_tgz/${MY_P}.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/projects/xenophilia"

DEPEND=">=x11-libs/gtk+-2.0.5"

SLOT="0" 
LICENSE="GPL-2"
KEYWORDS="x86 alpha"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	cp ${FILESDIR}/Makefile fonts/
	dodir /usr/X11R6/lib/X11/fonts/local/
	
	make ENGINE_DIR=${D}/usr/lib/gtk/themes/engines \
		THEME_DIR=${D}/usr/share/themes \
		DESTDIR=${D}/usr/X11R6/lib/X11/fonts/local/ install || die
	
	dodoc AUTHORS BUGS CONFIGURATION COPYING ChengeLog INSTALL README TODO
}

pkg_config () {
	einfo "Please run \"xset fp rehash\" to let your X server"
	einfo "pick up the new fonts."
}
