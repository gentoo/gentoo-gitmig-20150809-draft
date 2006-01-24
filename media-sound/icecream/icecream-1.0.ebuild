# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/icecream/icecream-1.0.ebuild,v 1.1 2006/01/24 20:58:12 chutzpah Exp $

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://icecream.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""
LICENSE="GPL-2"
SLOT="0"

RDEPEND="dev-lang/perl"

src_install() {
	doman icecream.8
	dobin icecream
}
