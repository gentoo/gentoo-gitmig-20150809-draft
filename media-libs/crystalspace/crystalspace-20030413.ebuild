# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/crystalspace/crystalspace-20030413.ebuild,v 1.1 2003/04/15 19:52:46 malverian Exp $

IUSE="oggvorbis mikmod"

#Local USE flags
IUSE="${IUSE} openal freetype 3ds mng"

S=${WORKDIR}/CS

CRYSTAL_PREFIX="/opt/crystal"

DESCRIPTION="A nice 3d engine"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="http://crystal.sourceforge.net"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b
	mng? 		( media-libs/libmng )
	mikmod?		( media-libs/libmikmod )
	3ds?		( media-libs/lib3ds )
	freetype?	( >=media-libs/freetype-2.0 )
	openal?		( media-libs/openal )
	zlib? 		( sys-libs/zlib )
	oggvorbis?	( >=media-libs/libogg-1.0 )
	oggvorbis?	( >=media-libs/libvorbis-1.0 )
	x86? 		( dev-lang/nasm )
	dev-libs/ode 
	>=dev-lang/perl-5.6.1
	"

src_compile() {

	cd ${S}
	./configure --prefix=${D}/${CRYSTAL_PREFIX} || die

	make all
}

src_install() {
	dodir /opt /etc/env.d /usr/bin

	make INSTALL_DIR=${D}/${CRYSTAL_PREFIX} install || die
	echo "CRYSTAL=${CRYSTAL_PREFIX} CEL=${CRYSTAL_PREFIX}" > ${D}/etc/env.d/15crystalspace

	dosym /opt/crystal/bin/cs-config /usr/bin/cs-config
}
