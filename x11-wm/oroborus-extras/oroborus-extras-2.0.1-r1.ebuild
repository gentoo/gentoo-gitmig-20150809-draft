# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus-extras/oroborus-extras-2.0.1-r1.ebuild,v 1.19 2007/07/12 03:41:52 mr_bones_ Exp $

S=${WORKDIR}
DESCRIPTION="Other stuff for oroborus"
SRC_URI="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/deskmenu-1.3.0.tar.gz
	http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/keylaunch-1.3.0.tar.gz
	http://www.kensden.pwp.blueyonder.co.uk/Oroborus/files/desklaunch-1.1.0.tar.gz"
HOMEPAGE="http://www.kensden.pwp.blueyonder.co.uk/Oroborus/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

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
