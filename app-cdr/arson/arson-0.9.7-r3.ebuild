# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/arson/arson-0.9.7-r3.ebuild,v 1.1 2003/04/12 21:26:30 brain Exp $
inherit kde-base
inherit eutils

DESCRIPTION="A KDE frontend to CD burning and CD ripping tools."
HOMEPAGE="http://arson.sourceforge.net/"
LICENSE="GPL-2"

newdepend ">=media-sound/cdparanoia-3.9.8
	>=media-sound/bladeenc-0.94.2
	>=app-cdr/cdrtools-1.11.24
	>=media-sound/normalize-0.7.4
	oggvorbis? ( media-libs/libvorbis )
	>=media-sound/lame-3.92
	>=app-cdr/cdrdao-1.1.5
   	>=media-libs/flac-1.1.0"
need-kde 3
	   
IUSE="oggvorbis"
KEYWORDS="~x86"
S=${WORKDIR}/${P}-kde3
SRC_URI="mirror://sourceforge/arson/${P}-kde3.tar.bz2"

use oggvorbis && myconf="$myconf --with-vorbis" || myconf="$myconf --without-vorbis"
myconf="$myconf --with-flac"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-write-img-fix.diff
	epatch ${FILESDIR}/${P}-crashfix.diff
}
