# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Updated to 0.13.0 (development release) by Brandon Low <lostlogic@lostlogicx.com>
# /media-sound/gqmpeg/gqmpeg-0.13.0.ebuild

S=${WORKDIR}/${P}
DESCRIPTION="front end to various audio players, including mpg123"
SRC_URI="http://prdownloads.sourceforge.net/gqmpeg/${P}.tar.gz"
HOMEPAGE="http://gqmpeg.sourceforge.net/"

DEPEND="=x11-libs/gtk+-1.2*
		>=media-libs/gdk-pixbuf-0.13.0
		nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi						
	./configure --host=${CHOST} \
		${myconf} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc [A-KN-Z]*
	if use gnome; then
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/gqmpeg.desktop
	fi
}
