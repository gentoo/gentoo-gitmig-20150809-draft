# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.9.ebuild,v 1.6 2003/09/08 02:00:39 caleb Exp $

inherit kde-base
need-kde 3.1

MY_P=${P/_/""}
S=${WORKDIR}/${MY_P}

DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://k3b.sourceforge.net/"
SRC_URI="mirror://sourceforge/k3b/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="debug"

newdepend ">=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/id3lib-3.8.0_pre2
	>=media-sound/mad-0.14.2b
	media-libs/libvorbis"

RDEPEND="$RDEPEND sys-apps/eject
	>=app-cdr/cdrtools-1.11
	>=app-cdr/cdrdao-1.1.5
	media-sound/normalize
	dvd? ( media-video/transcode media-libs/xvid )"

myconf="$myconf --enable-sso"
[ `use debug` ] \
	&& myconf="$myconf --enable-debugging --enable-profiling" \
	|| myconf="$myconf --disable-debugging --disable-profiling"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_postinst()
{
	einfo "The k3b setup program will offer to change some permissions and"
	einfo "create a user group.  These changes are not necessary.  We recommend"
	einfo "that you clear the two check boxes that let k3b make changes for"
	einfo "cdrecord and cdrdao and let k3b make changes for the devices when"
	einfo "running k3b setup."
}
