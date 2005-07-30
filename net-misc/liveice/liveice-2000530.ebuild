# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/liveice/liveice-2000530.ebuild,v 1.8 2005/07/30 18:15:45 swegener Exp $

S=${WORKDIR}/${PN}
IUSE=""
DESCRIPTION="Live Source Client For IceCast"
HOMEPAGE="http://star.arm.ac.uk/~spm/software/liveice.html"
SRC_URI="http://star.arm.ac.uk/~spm/software/liveice.tar.gz"

SLOT="0"
KEYWORDS="x86"
LICENSE="as-is"

DEPEND="virtual/libc"
RDEPEND="media-sound/lame
	virtual/mpg123"

src_compile() {
	./configure
	emake || die
}

src_install() {
	dobin liveice
	dodoc liveice.cfg README.liveice README.quickstart README_new_mixer.txt Changes.txt
}
