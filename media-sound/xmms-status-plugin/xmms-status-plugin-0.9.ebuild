# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Matthew Kennedy <mkennedy@gentoo.org>
# Author: Gary Chisholm <gary@nexlinks.net>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-status-plugin/xmms-status-plugin-0.9.ebuild,v 1.1 2002/04/18 05:02:02 mkennedy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Provides a docklet for the GNOME Status applet and the KDE panel."
SRC_URI="http://www.hellion.org.uk/source/${P}.tar.gz"
HOMEPAGE="http://www.hellion.org.uk/xmms-status-plugin/"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
        >=media-sound/xmms-1.2.7
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls && myconf='--enable-nls' || myconf='--disable-nls'

	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man	\
		--host=${CHOST} \
		${myconf} || die

	emake || die
}


src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}


