# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}
DESCRIPTION="Other stuff for oroborus"
SRC_URI="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/deskmenu-1.3.0.tar.gz
	 http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/keylaunch-1.3.0.tar.gz
	 http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/desklaunch-1.1.0.tar.gz"
HOMEPAGE="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="x11-wm/oroborus
		=x11-libs/gtk+-1.2*"


src_unpack() {

	unpack ${A}

	cd ${S}/keylaunch
	sed -e 's:/usr/X11:/usr/X11R6:' Makefile |cat >Makefile
}

src_compile() {

# Deskmenu first
	cd ${S}/deskmenu-1.3.0
	make PREFIX=/usr || die

# Keylaunch next
	cd ${S}/keylaunch
	make PREFIX=/usr || die

# Desklaunch last
	cd ${S}/desklaunch
	make PREFIX=/usr || die
}

src_install () {

	dodir /usr/bin
	
# Deskmenu first
	cd ${S}/deskmenu-1.3.0
	make PREFIX=${D}/usr install || die
	
	newdoc README README.deskmenu
	newdoc CHANGES CHANGES.deskmenu
	newdoc example_rc example_rc.deskmenu
	dodoc LICENSE

# Keylaunch next 
	cd ${S}/keylaunch
	make PREFIX=${D}/usr install || die
	
	newdoc README README.keylaunch
	newdoc LICENSE LICENSE.keylaunch
	newdoc example_rc example_rc.keylaunch

# Desklaunch last
	cd ${S}/desklaunch
	make PREFIX=${D}/usr install || die
	
	newdoc README README.desklaunch
}

