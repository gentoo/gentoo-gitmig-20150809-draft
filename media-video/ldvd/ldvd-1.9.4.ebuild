# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ldvd/ldvd-1.9.4.ebuild,v 1.2 2005/07/28 10:37:52 dholm Exp $

DESCRIPTION="dvd ripping tool with GUI"
HOMEPAGE="http://ldvd9to5.gff-clan.net/"
SRC_URI="http://files.gff-clan.net/pub/ldvd/testing/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""
SLOT="0"

RDEPEND=">=media-video/dvdauthor-0.6.10
	 >=app-cdr/cdrtools-2.01
	 >=app-cdr/dvd+rw-tools-5.17.4.8.6
	 >=sys-block/buffer-1.19-r1
	 >=media-video/mjpegtools-1.6.2
	 >=dev-perl/gtk-perl-0.7008-r11"

src_install() {
	make DESTDIR=${D} install || die
}
