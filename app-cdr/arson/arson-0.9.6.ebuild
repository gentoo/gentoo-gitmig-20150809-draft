# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Heaer: $

IUSE="oggvorbis"

inherit kde-base

need-kde 3

S=${WORKDIR}/${P}-kde3
DESCRIPTION="A KDE frontend to CD burning and CD ripping tools."
SRC_URI="mirror://sourceforge/arson/${P}-kde3.tar.bz2"
HOMEPAGE="http://arson.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

newdepend ">=media-sound/cdparanoia-3.9.8
	   >=media-sound/bladeenc-0.94.2
	   >=app-cdr/cdrtools-1.11.24
	   >=media-sound/normalize-0.7.4
	   oggvorbis? ( media-libs/libvorbis )
	   >=media-sound/lame-3.92
	   >=app-cdr/cdrdao-1.1.5"
	   
use oggvorbis && myconf="$myconf --with-vorbis" || myconf="$myconf --without-vorbis"

