# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/logjam/logjam-3.0.4.ebuild,v 1.2 2002/08/01 13:09:06 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"
SRC_URI=http://logjam.danga.com/download/${P}.tar.gz

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-1.2.10
	net-ftp/curl
	gnome?	( >=gnome-base/gnome-core-1.4.0 )
	xmms? ( media-sound/xmms )"

src_compile () {
	local myconf

	use gnome && myconf="${myconf} --with-gnome=yes"
	use xmms && myconf="${myconf} --enable-xmms"
	
	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README TODO ChangeLog COPYING AUTHORS
}
