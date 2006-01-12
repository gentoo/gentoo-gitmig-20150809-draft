# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-4.4.0-r1.ebuild,v 1.4 2006/01/12 23:45:26 compnerd Exp $

IUSE="xmms spell gtkhtml"

inherit eutils

DESCRIPTION="GTK2-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"
SRC_URI="http://logjam.danga.com/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.0
	net-misc/curl
	gtkhtml? ( =gnome-extra/gtkhtml-3.0.10* )
	spell? ( app-text/gtkspell )
	xmms? ( media-sound/xmms )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.4.patch
	epatch ${FILESDIR}/${P}-offline-sync.patch

	sed -i -e s/logjam.png/logjam_pencil.png/ ${S}/data/logjam.desktop.in

}

src_compile() {

	econf \
	`use_enable xmms` \
	`use_with gtkhtml` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc doc/README doc/TODO
}
