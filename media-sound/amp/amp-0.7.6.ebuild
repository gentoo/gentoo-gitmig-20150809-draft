# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amp/amp-0.7.6.ebuild,v 1.3 2003/09/08 07:09:44 msterret Exp $

DESCRIPTION="AMP - the Audio Mpeg Player"
LICENSE="as-is"

SRC_URI="http://distro.ibiblio.org/pub/Linux/distributions/slackware/slackware_source/ap/amp/${P}.tar.gz"
KEYWORDS='x86'
SLOT="0"
S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	patch -p0 <${FILESDIR}/${P}-gentoo.diff || die
	emake || die
}

src_install() {
	dobin amp || die
	dodoc BUGS CHANGES README TODO doc/*
}
