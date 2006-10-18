# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/crystalspace-cvs/crystalspace-cvs-0.99.ebuild,v 1.8 2006/10/18 20:59:24 nyhm Exp $

ECVS_SERVER="crystal.cvs.sourceforge.net:/cvsroot/crystal"
ECVS_MODULE="CS"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
inherit cvs

DESCRIPTION="portable 3D Game Development Kit written in C++"
HOMEPAGE="http://www.crystalspace3d.org"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="vorbis mikmod openal truetype 3ds mng"

RDEPEND="sys-libs/zlib
	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b
	mng? ( media-libs/libmng )
	mikmod? ( media-libs/libmikmod )
	3ds? ( media-libs/lib3ds )
	truetype? ( >=media-libs/freetype-2.0 )
	openal? ( media-libs/openal )
	vorbis? (
		>=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	dev-games/ode
	>=dev-lang/perl-5.6.1"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	dev-util/jam
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/${ECVS_MODULE}"

CRYSTAL_PREFIX="/opt/crystal-cvs"

src_compile() {
	./configure --prefix=${CRYSTAL_PREFIX} || die "configure failed"
	jam all || die "compile failed"
}

src_install() {
	jam -sprefix="${D}"${CRYSTAL_PREFIX} install

	# symlink for cs-config
	dodir /usr/bin
	dosym ${CRYSTAL_PREFIX}/bin/cs-config /usr/bin/cs-config

	# make sure these files dont have $D
	dosed ${CRYSTAL_PREFIX}/{bin/cs-config,etc/crystalspace/vfs.cfg}

	# fix perms so everyone can read these things
	find "${D}"/${CRYSTAL_PREFIX} -type f -exec chmod a+r '{}' \;
	find "${D}"/${CRYSTAL_PREFIX} -type d -exec chmod a+rx '{}' \;
	chmod a+rx "${D}"/${CRYSTAL_PREFIX}/bin/*

	dodir /etc/env.d
	echo "CRYSTAL=\"${CRYSTAL_PREFIX}\"" > 90crystalspace
	doenvd 90crystalspace
}
