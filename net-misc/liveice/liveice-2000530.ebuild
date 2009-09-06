# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/liveice/liveice-2000530.ebuild,v 1.9 2009/09/06 17:59:57 ssuominen Exp $

DESCRIPTION="Live Source Client For IceCast"
HOMEPAGE="http://star.arm.ac.uk/~spm/software/liveice.html"
SRC_URI="http://star.arm.ac.uk/~spm/software/liveice.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="media-sound/lame
	media-sound/mpg123"
DEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	dobin liveice || die
	dodoc liveice.cfg README.liveice README.quickstart README_new_mixer.txt Changes.txt
}
