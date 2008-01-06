# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/lightspeed/lightspeed-1.2a.ebuild,v 1.3 2008/01/06 16:46:45 bicatali Exp $

DESCRIPTION="OpenGL interactive relativistic simulator"
HOMEPAGE="http://lightspeed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	 mirror://sourceforge/${PN}/objects-1.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

IUSE=""

DEPEND="virtual/opengl
	=x11-libs/gtkglarea-1.2.3-r1
	>=x11-libs/gtk+-1.0.1
	media-libs/libpng
	media-libs/tiff"

S2="${WORKDIR}/objects"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog MATH NEWS README TODO || die
	cd ${S2}
	newdoc README objects-README || die
	insinto /usr/share/${PN}
	doins *.3ds *.lwo || die
}

pkg_postinst() {
	elog
	elog "Some 3d models have been placed in /usr/share/${PN}"
	elog "You can load them in Light Speed! from the File menu."
	elog
}
