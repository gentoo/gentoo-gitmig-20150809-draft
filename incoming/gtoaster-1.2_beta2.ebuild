# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Claes Nästén <pekdon@gmx.net>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

P=gtoaster1.0Beta2
PV=1.0beta2
S=${WORKDIR}/gtoaster
DESCRIPTION="GTK+ Frontend for cdrecord"
SRC_URI="http://gnometoaster.rulez.org/archive/${P}.tgz"
HOMEPAGE="http://gnometoaster.rulez.org/"

DEPEND=">=x11-libs/gtk+-1.2
	gnome? ( >=gnome-base/gnome-core-1.2.2.1 )
	esd? ( >=media-sound/esound-0.2.22 )"

RDEPEND=">=app-cdr/cdrecord-1.9
	>=media-sound/sox-12
	>=media-sound/mpg123-0.59"

src_compile() {
	local myconf
	use gnome	&& myconf="$myconf --with-gnome"
	use gnome	|| myconf="$myconf --without-gnome"
	use esd		&& myconf="$myconf --with-esd"
	use esd		|| myconf="$myconf --without-esd"
	use oss		&& myconf="$myconf --with-oss"
	use oss		|| myconf="$myconf --without-oss"
	

	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} $myconf || die
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die
	dodoc Changelog* COPYING INSTALL NEWS README TODO
}

