# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-4.5.2.ebuild,v 1.5 2007/06/17 09:13:44 eva Exp $

IUSE="gtk gtkhtml spell sqlite svg"

inherit

DESCRIPTION="GTK2-based LiveJournal client"
HOMEPAGE="http://logjam.danga.com/"
SRC_URI="http://logjam.danga.com/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND=">=dev-libs/libxml2-2.0
	net-misc/curl
	>=dev-libs/glib-2
	gtk? ( >=x11-libs/gtk+-2.4 )
	gtkhtml? ( || (
		=gnome-extra/gtkhtml-3.6*
		=gnome-extra/gtkhtml-3.0* ) )
	spell? ( app-text/gtkspell )
	svg? ( >=gnome-base/librsvg-2.2.3 )
	sqlite? ( >=dev-db/sqlite-3 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	sed -i -e s/logjam.png/logjam_pencil.png/ ${S}/data/logjam.desktop.in
}

src_compile() {

	econf \
	`use_with gtk` \
	`use_with gtkhtml` \
	`use_with spell gtkspell` \
	`use_with svg librsvg` \
	`use_with sqlite sqlite3` \
	--without-xmms || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc Changelog doc/README doc/TODO
}
