# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/normalize/normalize-0.7.4.ebuild,v 1.3 2002/07/21 13:50:33 seemant Exp $

DESCRIPTION="Audio file volume normalizer"
HOMEPAGE="http://www.cs.columbia.edu/~cvaill/normalize"
SRC_URI="http://www.cs.columbia.edu/~cvaill/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2" 
KEYWORDS="x86"

RDEPEND="xmms? ( >=media-sound/xmms-1.2.7-r6 )
	>=media-libs/audiofile-0.2.3-r1
	>=media-sound/mad-0.14.2b-r1"

# NOTE: the "audiofile" and "mad" dependencies are NOT
# actually *required*, they are optional, but there are no
# appropriate USE variables.
#
# The libraries are quite small, so it does not seem to be that
# big a deal to force installation of them.
#

src_compile() {
	econf
		--with-audiofile \
		--with-mad || die

	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die
}
