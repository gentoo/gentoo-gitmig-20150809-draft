# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/yafray/yafray-0.0.7.ebuild,v 1.3 2004/10/28 06:42:16 lu_zero Exp $

inherit gcc eutils

DESCRIPTION="Yet Another Free Raytracer"
HOMEPAGE="http://www.yafray.org/"
SRC_URI="http://www.coala.uniovi.es/~jandro/noname/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND="media-libs/jpeg
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.3*
	>=sys-apps/sed-4
	dev-util/scons"

export WANT_GCC_3="yes"
export WANT_AUTOMAKE="1.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-scons.patch
	sed -i -e "s:-O3:${CFLAGS}:" SConstruct
}

src_compile() {
	scons prefix="/usr" || die
}

src_install() {
	scons prefix="/usr" destdir="${D}" install || die

	find ${D} -name .sconsign -exec rm \{\} \;
	dodoc AUTHORS 		|| die "dodoc failed"
	dohtml doc/doc.html || die "dohtml failed"
}
