# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-4.4.0.ebuild,v 1.7 2005/01/05 09:58:00 joem Exp $

IUSE="xmms spell gtkhtml"

inherit eutils

DESCRIPTION="GTK2-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"
SRC_URI="http://logjam.danga.com/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc amd64"

DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.0
	net-misc/curl
	gtkhtml? ( =gnome-extra/libgtkhtml-3.0.10* )
	spell? ( app-text/gtkspell )
	xmms? ( media-sound/xmms )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.4.patch

	sed -i -e s/logjam.png/logjam_pencil.png/ ${S}/data/logjam.desktop.in

}

src_compile() {
	local myconf

	use xmms && myconf="${myconf} --enable-xmms"
	use gtkhtml && myconf="${myconf} --with-gtkhtml"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc doc/README doc/TODO
}
