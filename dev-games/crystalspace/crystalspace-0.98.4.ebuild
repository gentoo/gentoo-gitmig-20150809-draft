# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/crystalspace/crystalspace-0.98.4.ebuild,v 1.8 2005/02/23 17:01:47 mr_bones_ Exp $

inherit eutils

MY_P="cs${PV:2:2}_00${PV:5:1}"
DESCRIPTION="portable 3D Game Development Kit written in C++"
HOMEPAGE="http://crystal.sourceforge.net/"
SRC_URI="mirror://sourceforge/crystal/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="3ds mikmod mng oggvorbis openal truetype"

RDEPEND="sys-libs/zlib
	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b
	mng? ( media-libs/libmng )
	mikmod? ( media-libs/libmikmod )
	3ds? ( media-libs/lib3ds )
	truetype? ( >=media-libs/freetype-2.0 )
	openal? ( media-libs/openal )
	oggvorbis? (
		>=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	dev-games/ode
	>=dev-lang/perl-5.6.1"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	|| ( dev-util/jam dev-util/boost-jam )
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/CS"

CRYSTAL_PREFIX="/opt/crystal"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gl.patch" #75702
	echo "CRYSTAL=\"${CRYSTAL_PREFIX}\"" > 90crystalspace
}

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

	doenvd 90crystalspace
}
