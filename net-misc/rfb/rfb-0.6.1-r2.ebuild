# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rfb/rfb-0.6.1-r2.ebuild,v 1.4 2004/07/15 03:23:31 agriffis Exp $

inherit eutils

DESCRIPTION="comprehensive collection of rfb enabled tools and applications"
HOMEPAGE="http://forum.hexonet.com/"
SRC_URI="http://download.hexonet.com/software/rfb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="x11-libs/xclass"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.x.patch
	epatch ${FILESDIR}/${P}-daemon.patch
}

src_compile() {
	make depend || die "make depend failed"
	make CXXFLAGS="-DUSE_ZLIB_WARREN -I../include ${CXXFLAGS}" || die "make failed"
}

src_install() {
#	dolib lib/librfb.a	#does anything other than rfb use this ?

	dobin rfbcat/rfbcat x0rfbserver/x0rfbserver \
		xrfbviewer/{xplayfbs,xrfbviewer}
	for f in rfbcat x0rfbserver xvncconnect xrfbviewer ; do
		dobin ${f}/${f}
	done

	doman man/man1/*

	dodoc README
	dohtml rfm_fbs.1.0.html
}
