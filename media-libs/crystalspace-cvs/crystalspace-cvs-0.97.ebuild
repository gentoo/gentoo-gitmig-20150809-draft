# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/crystalspace-cvs/crystalspace-cvs-0.97.ebuild,v 1.1 2003/04/03 14:02:30 malverian Exp $

IUSE="oggvorbis mikmod"

#Local USE flags
IUSE="${IUSE} openal freetype 3ds mng"

S=${WORKDIR}/CS
CRYSTAL_PREFIX="/opt/crystal"

DESCRIPTION="A nice 3d engine"
HOMEPAGE="http://crystal.sourceforge.net"

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

inherit cvs

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/crystal"
ECVS_MODULE="CS"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}


src_compile() {
	local myconf=""

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
