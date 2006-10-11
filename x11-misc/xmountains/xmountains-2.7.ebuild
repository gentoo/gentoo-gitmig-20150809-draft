# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmountains/xmountains-2.7.ebuild,v 1.9 2006/10/11 11:35:19 nelchael Exp $

DESCRIPTION="Fractal terrains of snow-capped mountains near water"
HOMEPAGE="http://www.epcc.ed.ac.uk/~spb/xmountains/"
MY_P="${P/-/_}"
SRC_URI="http://www.epcc.ed.ac.uk/~spb/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
IUSE=""

RDEPEND="|| ( (
		x11-misc/xbitmaps
		x11-libs/libX11 )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-misc/imake )
	virtual/x11 )"

src_compile() {
	xmkmf || die
	emake CCOPTIONS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		BINDIR="/usr/bin" \
		install || die "install failed"
	dodoc README
	newman xmountains.man xmountains.1
}
