# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip/grip-3.1.1.ebuild,v 1.1 2003/07/11 16:59:33 mholzer Exp $

inherit eutils

DESCRIPTION="GTK+ based Audio CD Player/Ripper."
HOMEPAGE="http://www.nostatic.org/grip"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-2.2*
	=sys-libs/db-1*
	media-sound/lame
	media-sound/cdparanoia
	media-libs/id3lib
	gnome-base/gnome-libs
	gnome-base/ORBit2
	gnome-base/libghttp
	oggvorbis? ( media-sound/vorbis-tools )
	nls? ( sys-devel/gettext )"

IUSE="nls oggvorbis"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

SRC_URI="http://www.nostatic.org/grip/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	local myconf=
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die

	dodoc ABOUT-NLS AUTHORS CREDITS COPYING ChangeLog README TODO
}
