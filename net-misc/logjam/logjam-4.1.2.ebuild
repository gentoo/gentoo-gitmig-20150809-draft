# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-4.1.2.ebuild,v 1.2 2003/05/10 23:04:43 liquidx Exp $

IUSE="xmms spell"

DESCRIPTION="GTK2-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"
SRC_URI="http://logjam.danga.com/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.5
	net-ftp/curl
	spell? ( app-text/gtkspell )
	xmms? ( media-sound/xmms )"

src_compile () {
	local myconf

	use xmms && myconf="${myconf} --enable-xmms"
	
	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README TODO ChangeLog COPYING AUTHORS
}
