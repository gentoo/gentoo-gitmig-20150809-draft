# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip/grip-3.1.4.ebuild,v 1.3 2004/01/27 14:37:15 weeve Exp $

inherit eutils

DESCRIPTION="GTK+ based Audio CD Player/Ripper."
HOMEPAGE="http://www.nostatic.org/grip"
SRC_URI="mirror://sourceforge/grip/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.2
	x11-libs/vte
	=sys-libs/db-1*
	media-sound/lame
	media-sound/cdparanoia
	>=media-libs/id3lib-3.8.3
	>=gnome-base/libgnomeui-2.2.0
	gnome-base/ORBit2
	gnome-base/libghttp
	oggvorbis? ( media-sound/vorbis-tools )
	nls? ( sys-devel/gettext )"

IUSE="nls oggvorbis"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~hppa ~sparc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-cdda.patch
}

src_compile() {
	econf --disable-dependency-tracking `use_enable nls` || die
	emake || die "emake failed"
}

src_install () {
	einstall || die
	dodoc AUTHORS CREDITS ChangeLog README TODO || die "dodoc failed"
}
