# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/net-news/knews/knews-1.0.1b-r1.ebuild,v 1.8 2004/03/20 07:32:10 mr_bones_ Exp $

MY_P=${PN}-1.0b.1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A threaded newsreader for X."
SRC_URI="http://www.matematik.su.se/~kjj/${MY_P}.tar.gz"
HOMEPAGE="http://www.matematik.su.se/~kjj/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-base/xfree-4.0
	>=media-libs/jpeg-6
	>=media-libs/libpng-1.2.1
	>=media-libs/compface-1.4"

# If knews used autoconf, we wouldn't need this patch.

src_compile() {
	xmkmf || die
	make Makefiles || die
	make clean || die
	make all || die
	pushd util/knewsd || die
	xmkmf || die
	make all || die
	popd || die
}

src_install () {
	#Install knews
	make DESTDIR=${D} install || die
	make DESTDIR=${D} DOCHTMLDIR=/usr/share/doc/${P} \
	MANPATH=/usr/share/man MANSUFFIX=1 install.man || die

	#Install knewsd
	pushd util/knewsd || die
	make DESTDIR=${D} install || die
	make DESTDIR=${D} DOCHTMLDIR=/usr/share/doc/${P} \
	MANPATH=/usr/share/man MANSUFFIX=1 install.man || die
	popd || die

	#Other docs.
	dodoc COPYING COPYRIGHT Changes README
}
