# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pekwm/pekwm-0.1.2.ebuild,v 1.3 2003/02/13 17:53:49 vapier Exp $

IUSE=""

S="${WORKDIR}/${P}"

DESCRIPTION="A small window mananger based on aewm++"
HOMEPAGE="http://pekwm.pekdon.net/"
SRC_URI="http://pekwm.pekdon.net/files/source/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11"

src_compile() {
	
	econf \
	    --enable-xft \
	    --enable-xinerama \
	    --enable-harbour	
	emake || die
}

src_install() {
    
	exeinto /usr/bin
	doexe src/pekwm
	insinto /usr/share/${PN}/themes/default
	doins data/themes/default/*.xpm data/themes/default/theme
	insinto /usr/share/${PN}
	cd ${S}/data
	doins autoprops config keys menu mouse start
	cd ${S}
	doman docs/pekwm.1
	dodoc docs/pekwmdocs.txt AUTHORS ChangeLog* INSTALL LISCENCE README* NEWS ROADMAP TODO	
}



