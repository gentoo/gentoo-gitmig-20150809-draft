# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pekwm/pekwm-0.1.3.ebuild,v 1.1 2003/06/08 23:17:36 seemant Exp $

IUSE=""

S="${WORKDIR}/${P}"

DESCRIPTION="A small window mananger based on aewm++"
HOMEPAGE="http://pekwm.pekdon.net/"
SRC_URI="http://pekwm.pekdon.net/files/source/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-util/pkgconfig
	virtual/x11"

src_compile() {
	if pkg-config xft
	    then
		myconf="${myconf} --disable-xft"
	    else
		myconf="${myconf} --enable-xft"	
	fi
	
	econf \
	    --enable-xinerama \
	    --enable-harbour \
	    ${myconf} || die	
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
