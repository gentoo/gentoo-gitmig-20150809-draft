# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus-extras/oroborus-extras-2.0.13.ebuild,v 1.2 2003/09/06 04:16:43 msterret Exp $

S=${WORKDIR}
DESCRIPTION="Other stuff for oroborus"
SRC_URI="http://www.oroborus.org/debian/dists/sid/main/source/x11/keylaunch_1.3.0-6.tar.gz
	http://www.oroborus.org/debian/dists/sid/main/source/x11/deskmenu_1.4.0-2.tar.gz
	http://www.oroborus.org/debian/dists/sid/main/source/x11/desklaunch_1.1.3-1.tar.gz"
HOMEPAGE="http://www.oroborus.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND="x11-wm/oroborus
	=x11-libs/gtk+-1.2*
	>=x11-libs/gtk+-2.0.3"

src_unpack() {
	unpack ${A}
	cd ${S}/keylaunch-1.3.0
}

src_compile() {
# Deskmenu first
	echo "building deskmenu"
	cd ${S}/deskmenu-1.4.0
	./configure --prefix=/usr --sysconfdir=/etc/X11/oroborus --infodir=/usr/share/info --mandir=/usr/share/man
	make || die

# Keylaunch next
	echo "building keylaunch"
	cd ${S}/keylaunch-1.3.0
	make PREFIX=/usr || die

# Desklaunch last
	echo "building desklaunch"
	cd ${S}/desklaunch-1.1.3
	make PREFIX=/usr || die
}

src_install () {
	dodir /usr/bin

# Deskmenu first
	cd ${S}/deskmenu-1.4.0
	make prefix=${D}/usr sysconfdir=${D}/etc/X11/oroborus infodir=${D}/usr/share/info mandir=${D}/usr/share/man install || die

	newdoc README README.deskmenu
	newdoc CHANGES.deskmenu
	newdoc example_rc example_rc.deskmenu

# Keylaunch next
	cd ${S}/keylaunch-1.3.0
	make PREFIX=${D}/usr install || die

	newdoc README README.keylaunch
	newdoc LICENSE LICENSE.keylaunch
	newdoc example_rc example_rc.keylaunch

# Desklaunch last
	cd ${S}/desklaunch-1.1.3
	make PREFIX=${D}/usr install || die

	newdoc README README.desklaunch
}
