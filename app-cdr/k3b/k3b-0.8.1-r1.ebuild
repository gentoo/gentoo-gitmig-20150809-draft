# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.8.1-r1.ebuild,v 1.4 2003/08/01 20:11:43 vapier Exp $

inherit kde-base
need-kde 3

DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://k3b.sourceforge.net/"
SRC_URI="mirror://sourceforge/k3b/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="debug"

newdepend ">=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/id3lib-3.8.0_pre2
	>=media-sound/mad-0.14.2b-r1
	media-libs/libvorbis
	>=kde-base/kdebase-3"

RDEPEND="$RDEPEND sys-apps/eject
	>=app-cdr/cdrtools-1.11
	>=app-cdr/cdrdao-1.1.5
	media-sound/normalize
	dvd? ( media-video/transcode media-libs/xvid )"

myconf="$myconf --enable-sso"
[ `use debug` ] \
	&& myconf="$myconf --enable-debugging --enable-profiling" \
	|| myconf="$myconf --disable-debugging --disable-profiling"
