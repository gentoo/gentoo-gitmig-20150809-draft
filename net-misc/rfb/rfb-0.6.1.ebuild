# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rfb/rfb-0.6.1.ebuild,v 1.3 2002/12/15 10:44:21 bjb Exp $

DESCRIPTION="comprehensive collection of rfb enabled tools and applications"
HOMEPAGE="http://forums.hexonet.com/"
SRC_URI="http://download.hexonet.com/software/rfb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="x11-libs/xclass"

S="${WORKDIR}/${P}"

# todo: make this guy use zlib rather than the build in zlib functions ?

src_compile() {
	cd ${S}
	patch -p0<${FILESDIR}/gcc3.x-rfb-0.6.1.patch

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
