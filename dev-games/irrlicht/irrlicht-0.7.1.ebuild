# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/irrlicht/irrlicht-0.7.1.ebuild,v 1.3 2005/03/29 02:43:47 vapier Exp $

inherit eutils

DESCRIPTION="open source high performance realtime 3D engine written in C++"
HOMEPAGE="http://irrlicht.sourceforge.net/"
SRC_URI="mirror://sourceforge/irrlicht/irrlicht-0.7.zip
		mirror://sourceforge/irrlicht/${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="doc"

RDEPEND="media-libs/jpeg
	sys-libs/zlib
	virtual/opengl
	virtual/x11"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	mv irrlicht-0.7/{include,media,examples} ${P} || die "mv failed"
	cd "${S}/source"
	unzip -qo source.zip || die "unpacking source.zip"
	rm -f source.zip
	cd Irrlicht
	rm -rf zlib jpeglib
	ln -s /usr/include jpeglib
	ln -s /usr/include zlib
	epatch "${FILESDIR}/${PV}-system-libs.patch" || die "system libs patch failed"
	epatch "${FILESDIR}/${PV}-jpeg.patch" || die "JPEG patch failed"
	epatch "${FILESDIR}/${PV}-opengl.patch" || die "OpenGL patch failed"
}

src_compile() {
	emake -C source/Irrlicht || die "emake failed"
}

src_install() {
	dolib.a lib/Linux/libIrrlicht.a || die "dolib.a failed"
	insinto /usr/include/${PN}
	doins include/* || die "doins failed"
	dodoc changes.txt readme.txt
	if use doc ; then
		cp -r examples media "${D}/usr/share/doc/${PF}/" || die "cp failed"
	fi
}
