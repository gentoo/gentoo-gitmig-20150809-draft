# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-4.2.2.ebuild,v 1.10 2006/01/12 23:45:26 compnerd Exp $

DESCRIPTION="GTK2-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"
SRC_URI="http://logjam.danga.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"
IUSE="xmms spell gtkhtml"

DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.0
	net-misc/curl
	gtkhtml? ( =gnome-extra/gtkhtml-3.0.10* )
	spell? ( app-text/gtkspell )
	xmms? ( media-sound/xmms )"

src_compile() {
	local myconf

	use xmms && myconf="${myconf} --enable-xmms"
	use gtkhtml && myconf="${myconf} --with-gtkhtml"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README TODO ChangeLog AUTHORS
}
