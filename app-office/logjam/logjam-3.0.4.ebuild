# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/logjam/logjam-3.0.4.ebuild,v 1.1 2002/05/24 07:16:12 agenkin Exp $

DESCRIPTION="GTK-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"

DEPEND=">=x11-libs/gtk+-1.2.10
		net-ftp/curl
		gnome?	( >=gnome-base/gnome-core-1.4.0 )
		media-sound/xmms"

SRC_URI=http://logjam.danga.com/download/${P}.tar.gz
S=${WORKDIR}/${P}

src_compile () {
	local myopts

	use gnome && myopts="${myopts} --with-gnome=yes"
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-xmms \
		${myopts} || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README TODO ChangeLog COPYING AUTHORS
}
