# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/tear/tear-1.0_rc1.ebuild,v 1.8 2003/06/29 16:01:56 aliz Exp $

DESCRIPTION="T.E.A.R. Encodes And Rips CDs into mp3 or ogg files."
HOMEPAGE="http://tear.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
IUSE="encode oggvorbis"

RDEPEND="dev-lang/perl
	>=dev-perl/CDDB_get-2.1.0
	>=dev-perl/MP3-Info-1.01
	encode? ( >=media-sound/lame-3.92 )
	>=media-sound/bladeenc-0.94.2 
	>=media-sound/gogo-3.10 
	oggvorbis? ( >=media-sound/vorbis-tools-1.0 )
	>=media-sound/cdparanoia-3.9.8"

src_unpack() {
	unpack ${A}
	cd ${S}	
	
	mv tearrc tear.conf
	
	mv man-tear tear.1
	/usr/bin/groff -man -Tascii tear.1 > /dev/null
}

src_install() {
	dobin tear

	insinto /etc
	doins tear.conf	
	
	doman tear.1
	dodoc LICENSE README Changes
}
