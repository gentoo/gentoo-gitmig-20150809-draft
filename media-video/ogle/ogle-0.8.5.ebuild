# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle/ogle-0.8.5.ebuild,v 1.1 2002/09/21 21:56:30 agenkin Exp $

DESCRIPTION="Full featured DVD player that supports DVD menus."
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"
LICENSE="GPL-2"

inherit libtool

DEPEND="media-libs/libdvdcss
	media-libs/jpeg 
	media-libs/libdvdread 
	media-sound/mad
	x11-base/xfree
	>=dev-libs/libxml2-2.4.19
	>=media-libs/a52dec-0.7.3
	alsa? ( media-libs/alsa-lib )"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86"

SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {

	# STOP!  If you make any changes, make sure to unmerge all copies
	# of ogle and ogle-gui from your system and merge ogle-gui using your
	# new version of ogle... Changes in this package can break ogle-gui
	# very very easily -- blocke

	local myconf
	
	use mmx \
		&& myconf="--enable-mmx" \
		|| myconf="--disable-mmx"

	use oss \
		&& myconf="${myconf} --enable-oss" \
		|| myconf="${myconf} --disable-oss"

	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"

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
