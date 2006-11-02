# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ldvd/ldvd-1.9.4.ebuild,v 1.5 2006/11/02 15:48:52 zzam Exp $

inherit eutils

DESCRIPTION="dvd ripping tool with GUI"
HOMEPAGE="http://ldvd.sourceforge.net/"
SRC_URI="mirror://sourceforge/ldvd/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""
SLOT="0"

DEPEND="media-libs/libdvdread"

RDEPEND="${DEPEND}
	>=media-video/dvdauthor-0.6.10
	virtual/cdrtools
	>=app-cdr/dvd+rw-tools-5.17.4.8.6
	>=sys-block/buffer-1.19-r1
	>=media-video/mjpegtools-1.6.2
	>=dev-perl/gtk-perl-0.7008-r11"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-libdvdread-0.9.6.diff
	sed -i Makefile -e '/$(STRIP)/d'
}

src_install() {
	make DESTDIR=${D} install || die
}
