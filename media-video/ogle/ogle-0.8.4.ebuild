# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle/ogle-0.8.4.ebuild,v 1.8 2003/09/07 00:08:13 msterret Exp $

inherit libtool

DESCRIPTION="full featured DVD player that supports DVD menus"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="oss mmx alsa"

DEPEND="media-libs/libdvdcss
	media-libs/jpeg
	media-libs/libdvdread
	x11-base/xfree
	>=dev-libs/libxml2-2.4.19
	>=media-libs/a52dec-0.7.3
	alsa? ( media-libs/alsa-lib )"

src_compile() {
	# STOP!  If you make any changes, make sure to unmerge all copies
	# of ogle and ogle-gui from your system and merge ogle-gui using your
	# new version of ogle... Changes in this package can break ogle-gui
	# very very easily -- blocke

	local myconf="`use_enable mmx` `use_enable oss` `use_enable alsa`"

	elibtoolize

	# configure needs access to the updated CFLAGS
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml -I/usr/include/libxml2"

	econf ${myconf} || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS README TODO
	dodoc doc/liba52.txt
}
