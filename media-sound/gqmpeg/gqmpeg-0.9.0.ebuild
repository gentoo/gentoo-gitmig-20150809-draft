# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/gqmpeg/gqmpeg-0.9.0.ebuild,v 1.4 2002/07/11 06:30:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="front end to various audio players, including mpg123"
SRC_URI="mirror://sourceforge/gqmpeg/${P}.tar.gz"
HOMEPAGE="http://gqmpeg.sourceforge.net/"

DEPEND="=x11-libs/gtk+-1.2*
		>=media-libs/gdk-pixbuf-0.13.0"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info || die
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
