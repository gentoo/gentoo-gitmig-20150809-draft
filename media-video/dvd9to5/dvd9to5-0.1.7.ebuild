# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvd9to5/dvd9to5-0.1.7.ebuild,v 1.1 2005/03/29 05:33:36 chriswhite Exp $

DESCRIPTION="Perl script to backup the main feature of a DVD-9 on DVD-5"
HOMEPAGE="http://lakedaemon.netmindz.net/dvd9to5/"
SRC_URI="http://lakedaemon.netmindz.net/dvd9to5/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=media-video/transcode-0.6.11
	>=media-video/mjpegtools-1.6.2
	>=media-video/dvdauthor-0.6.10"

src_compile() {
	true # nothing to do
}

src_install() {
	dobin dvd9to5.pl
	dodoc CHANGELOG INSTALL README TODO dvd9to5.conf.example
}
