# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/acidrip/acidrip-0.9.ebuild,v 1.3 2003/11/18 17:32:34 mholzer Exp $

inherit perl-module

DESCRIPTION="A gtk-perl mplayer/mencoder frontend for ripping DVDs"
HOMEPAGE="http://acidrip.thirtythreeandathird.net"
SRC_URI="mirror://sourceforge/acidrip/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="encode"

DEPEND="dev-lang/perl
		dev-perl/gtk-perl
		dev-perl/glade-perl
		>=media-video/lsdvd-0.9
		media-video/mplayer
		encode? ( >=media-sound/lame-3.92 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:system "mplayer 2:system "which mplayer 2:' ${S}/Makefile.PL
}

src_compile() {
	perl-module_src_compile
}

src_install() {
	perl-module_src_install
	#dobin acidrip
	dodoc Documentation/*
}
