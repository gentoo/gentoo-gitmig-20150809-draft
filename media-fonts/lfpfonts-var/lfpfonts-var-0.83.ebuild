# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lfpfonts-var/lfpfonts-var-0.83.ebuild,v 1.3 2004/06/24 22:29:30 agriffis Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Linux Font Project variable-width fonts"
HOMEPAGE="http://dreamer.nitro.dk/linux/lfp/"
SRC_URI="http://dreamer.nitro.dk/linux/lfp/${P}.tar.bz2"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 sparc ppc alpha amd64"

DEPEND="virtual/x11"

src_install() {
	dodoc doc/*
	cd lfp-var
	insinto /usr/X11R6/lib/X11/fonts/lfp-var
	insopts -m0644
	doins *
}
