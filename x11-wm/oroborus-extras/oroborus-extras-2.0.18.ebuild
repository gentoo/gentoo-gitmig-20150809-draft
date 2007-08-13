# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus-extras/oroborus-extras-2.0.18.ebuild,v 1.4 2007/08/13 22:10:52 dertobi123 Exp $

inherit eutils

DESCRIPTION="Other stuff for oroborus"
SRC_URI="http://www.oroborus.org/debian/dists/sid/main/source/x11/keylaunch_1.3.3.tar.gz
	http://www.oroborus.org/debian/dists/sid/main/source/x11/deskmenu_1.4.2.tar.gz
	http://www.oroborus.org/debian/dists/sid/main/source/x11/desklaunch_1.1.5.tar.gz"
HOMEPAGE="http://www.oroborus.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc ~x86"
IUSE=""

RDEPEND="x11-wm/oroborus
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_compile() {
# Deskmenu first
	echo "building deskmenu"
	cd ${S}/deskmenu-1.4.2
	./configure --prefix=/usr --sysconfdir=/etc/X11/oroborus --infodir=/usr/share/info --mandir=/usr/share/man
	make || die

# Keylaunch next
	echo "building keylaunch"
	cd ${S}/keylaunch-1.3.3
	./configure --prefix=/usr --sysconfdir=/etc/X11/oroborus
	--infodir=/usr/share/info --mandir=/usr/share/man
	make || die

# Desklaunch last
	echo "building desklaunch"
	cd ${S}/desklaunch-1.1.5
	make PREFIX=/usr || die
}

src_install () {
	dodir /usr/bin

# Deskmenu first
	cd ${S}/deskmenu-1.4.2
	make prefix=${D}/usr sysconfdir=${D}/etc/X11/oroborus infodir=${D}/usr/share/info mandir=${D}/usr/share/man install || die

	newdoc README README.deskmenu
	newdoc CHANGES.deskmenu
	newdoc example_rc example_rc.deskmenu

# Keylaunch next
	cd ${S}/keylaunch-1.3.3
	make PREFIX=${D}/usr install || die

	newdoc README README.keylaunch
	newdoc LICENSE LICENSE.keylaunch
	newdoc example_rc example_rc.keylaunch

# Desklaunch last
	cd ${S}/desklaunch-1.1.5
	make PREFIX=${D}/usr install || die

	newdoc README README.desklaunch
}
