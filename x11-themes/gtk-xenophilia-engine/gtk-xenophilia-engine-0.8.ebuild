# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/Xenophilia-0.8
P=xenophilia-0.8
DESCRIPTION="Gtk+-2 engine, xfce"
SRC_URI="http://themes.freshmeat.net/redir/xenophilia/24574/url_tgz/${P}.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/projects/xenophilia"

DEPEND=">=x11-libs/gtk+-2.0.5"
RDEPEND="$DEPEND"

LICENSE="GPL-2"
SLOT="0" 
KEYWORDS="x86"

src_compile() {
	econf
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

einfo "${GOOD}************************************************************** *${NORMAL}"
	einfo "                                                               ${GOOD}*${NORMAL}"
	einfo "After merge please run,   xset fp rehash                       ${GOOD}*${NORMAL}"
	einfo "                                                               ${GOOD}*${NORMAL}"
	einfo "${GOOD}************************************************************** *${NORMAL}"

}
