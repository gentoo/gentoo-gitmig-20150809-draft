# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-4.3.2.ebuild,v 1.3 2004/03/20 00:49:36 weeve Exp $

IUSE="xmms spell gtkhtml"

DESCRIPTION="GTK2-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"
SRC_URI="http://logjam.danga.com/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.0
	net-ftp/curl
	gtkhtml? ( >=gnome-extra/libgtkhtml-3.0 )
	spell? ( app-text/gtkspell )
	xmms? ( media-sound/xmms )"

src_compile () {
	local myconf

	use xmms && myconf="${myconf} --enable-xmms"
	use gtkhtml && myconf="${myconf} --with-gtkhtml"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc doc/README doc/TODO ChangeLog COPYING AUTHORS
}
