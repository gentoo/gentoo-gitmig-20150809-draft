# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dpencoder/dpencoder-0.6c.ebuild,v 1.1 2004/03/09 03:13:45 rphillips Exp $

inherit perl-module

DESCRIPTION="A PerlQT frontend to rip DVDs"
HOMEPAGE="http://dpencoder.sourceforge.net/"
SRC_URI="mirror://sourceforge/dpencoder/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${P}/DPencoder

DEPEND="dev-lang/perl
		dev-perl/PerlQt
		media-libs/libdvdread
		>=media-video/mplayer-1.0_pre1"

src_compile() {
	perl-module_src_compile
}

src_install() {
	perl-module_src_install
	dodoc README
}
