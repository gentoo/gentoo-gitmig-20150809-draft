# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/lightspeed/lightspeed-1.2a.ebuild,v 1.3 2003/07/02 12:33:39 aliz Exp $

DESCRIPTION="Light Speed! is an OpenGL-based program developed to illustrate the effects of special relativity on the appearance of moving objects."
HOMEPAGE="http://lightspeed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	 mirror://sourceforge/${PN}/objects-1.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

IUSE="png tiff"
DEPEND="virtual/opengl
	=x11-libs/gtkglarea-1.2.3-r1
	>=x11-libs/gtk+-1.0.1
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )"
#RDEPEND=""
S="${WORKDIR}/${P}"
S2="${WORKDIR}/objects"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL MATH NEWS README TODO
	cd ${S2}
	mv README objects-README
	dodoc objects-README
	insinto /usr/share/${PN}
	doins *.3ds *.lwo
}

pkg_postinst() {
	einfo
	einfo "Some 3d models have been placed in /usr/share/${PN}"
	einfo "You can load them in Light Speed! from the File menu."
	einfo
}

