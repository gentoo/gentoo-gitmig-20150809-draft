# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/vcr/vcr-1.10.ebuild,v 1.5 2004/06/25 00:34:28 agriffis Exp $

DESCRIPTION="VCR - Linux Console VCR"
HOMEPAGE="http://www.stack.nl/~brama/vcr/"
SRC_URI="http://www.stack.nl/~brama/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-video/avifile-0.7.37"

src_install () {
	einstall
	dodoc AUTHORS ChangeLog NEWS README
}
