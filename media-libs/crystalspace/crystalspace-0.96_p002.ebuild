# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/crystalspace/crystalspace-0.96_p002.ebuild,v 1.2 2003/04/02 19:40:00 malverian Exp $

IUSE="oggvorbis mikmod"

#Local USE flags
IUSE="${IUSE} openal freetype 3ds mng"

MY_PV0=${PV/_????}
MY_PV=${MY_PV0/.}
MY_PV1=${PV/p}
MY_PV2=${MY_PV1/0.}

S=${WORKDIR}/CS

CRYSTAL_PREFIX="/opt/crystal"

DESCRIPTION="A nice 3d engine"
SRC_URI="ftp://sunsite.dk/projects/crystal/cs${MY_PV}/source/cs${MY_PV2}.tar.bz2"
HOMEPAGE="http://crystal.sf.net"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc"

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

src_unpack() {
	unpack cs${MY_PV2}.tar.bz2
}

src_compile() {
	local myconf=""

#	myconf="${myconf} --without-libode"

	cd ${S}
	./configure --prefix=${CRYSTAL_PREFIX} ${myconf} || die

	emake all || die
}

src_install() {
	dodir /opt /etc/env.d /usr/bin

	make INSTALL_DIR=${D}/${CRYSTAL_PREFIX} install
	echo "CRYSTAL=${CRYSTAL_PREFIX}" > ${D}/etc/env.d/15crystalspace

	dosym /opt/crystal/bin/cs-config /usr/bin/cs-config
}
