# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/logjam/logjam-4.5.0.ebuild,v 1.1 2005/08/24 16:33:38 joem Exp $

IUSE="gtk gtkhtml spell sqlite svg xmms"

inherit

DESCRIPTION="GTK2-based LiveJournal client"
HOMEPAGE="http://neugierig.org/software/logjam/"
SRC_URI="http://neugierig.org/software/logjam/download//${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND=">=dev-libs/libxml2-2.0
	net-misc/curl
	gtk? ( >=x11-libs/gtk+-2 )
	gtkhtml? ( =gnome-extra/libgtkhtml-3.0.10* )
	spell? ( app-text/gtkspell )
	svg? ( >=gnome-base/librsvg-2.2.3 )
	xmms? ( media-sound/xmms )
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
	`use_with xmms` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc Changelog doc/README doc/TODO
}
