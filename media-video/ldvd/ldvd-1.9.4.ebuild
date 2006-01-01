# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ldvd/ldvd-1.9.4.ebuild,v 1.3 2006/01/01 18:20:04 chriswhite Exp $

DESCRIPTION="dvd ripping tool with GUI"
HOMEPAGE="http://ldvd.sourceforge.net/"
SRC_URI="mirror://sourceforge/ldvd/${P}.tar.bz2"
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
