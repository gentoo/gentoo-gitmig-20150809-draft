# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lfpfonts-var/lfpfonts-var-0.83.ebuild,v 1.12 2003/03/27 10:41:24 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Linux Font Project variable-width fonts"
HOMEPAGE="http://dreamer.nitro.dk/linux/lfp/"
SRC_URI="http://dreamer.nitro.dk/linux/lfp/${P}.tar.bz2"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 sparc ppc alpha"

DEPEND="virtual/x11"

src_install() {
	dodoc doc/*
	cd lfp-var
	insinto /usr/X11R6/lib/X11/fonts/lfp-var
	insopts -m0644
	doins *
}
