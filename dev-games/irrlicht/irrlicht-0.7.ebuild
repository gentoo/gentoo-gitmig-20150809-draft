# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/irrlicht/irrlicht-0.7.ebuild,v 1.1 2004/09/13 05:53:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="open source high performance realtime 3D engine written in C++"
HOMEPAGE="http://irrlicht.sourceforge.net/"
SRC_URI="mirror://sourceforge/irrlicht/${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND="media-libs/jpeg
	sys-libs/zlib
	virtual/opengl
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}/source
	unzip -qo source.zip || die "unpacking source.zip"
	rm -rf source.zip
	cd Irrlicht
	rm -rf zlib jpeglib
	ln -s /usr/include jpeglib
	ln -s /usr/include zlib
	epatch "${FILESDIR}/${PV}-system-libs.patch" || die "system libs patch failed"
	epatch "${FILESDIR}/${PV}-jpeg.patch" || die "JPEG patch failed"
	epatch "${FILESDIR}/${PV}-opengl.patch" || die "OpenGL patch failed"
}

src_compile() {
	cd source/Irrlicht
	emake || die "emake failed"
}

src_install() {
	dolib.a lib/Linux/libIrrlicht.a || die "dolib.a failed"
	insinto /usr/include/${PN}
	doins include/* || die "doins failed"
	dodoc changes.txt readme.txt
	use doc && cp -r examples media "${D}/usr/share/doc/${PF}/"
}
