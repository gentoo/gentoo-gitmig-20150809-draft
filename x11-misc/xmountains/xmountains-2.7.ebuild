# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmountains/xmountains-2.7.ebuild,v 1.7 2005/01/02 18:11:20 hansmi Exp $

DESCRIPTION="Fractal terrains of snow-capped mountains near water"
HOMEPAGE="http://www.epcc.ed.ac.uk/~spb/xmountains/"
MY_P="${P/-/_}"
SRC_URI="http://www.epcc.ed.ac.uk/~spb/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
IUSE=""

DEPEND="virtual/x11"

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
