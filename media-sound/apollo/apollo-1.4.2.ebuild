# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apollo/apollo-1.4.2.ebuild,v 1.10 2004/11/23 03:16:02 eradicator Exp $

inherit eutils

IUSE="qt"

#kde support of apollo is only kde2, if anybody has kde2 and wants this support,#please test myconf="--detect-kde2". if this works, post your modified ebuild to
#http://bugs.gentoo.org (you also need some more files in src_install()) 

S=${WORKDIR}/${P}-1
DESCRIPTION="A Qt-based front-end to mpg123"
SRC_URI="mirror://sourceforge/apolloplayer/${PN}-src-${PV}-1.tar.bz2"
HOMEPAGE="http://www.apolloplayer.org"

SLOT="2"
LICENSE="GPL-2"
# -amd64: weird segfaults... try a later version...
KEYWORDS="-amd64 ~sparc x86"

DEPEND="virtual/mpg123
	media-libs/id3lib
	media-sound/madplay
	qt?		( x11-libs/qt )"

src_compile() {
	epatch ${FILESDIR}/${P}-gentoo.diff
	myconf="--without-kde2 --with-mad=/usr/lib"
	./configure.sh $myconf
	make || die "Make failed"
}

src_install() {
	dobin apollo apollo-client/apollo-client
	dodoc CREDITS GPL INSTALL README
}
