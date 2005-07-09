# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/crystalspace/crystalspace-0.99_pre20050518.ebuild,v 1.3 2005/07/09 17:21:16 agriffis Exp $

inherit debug

DESCRIPTION="portable 3D Game Development Kit written in C++"
HOMEPAGE="http://crystal.sourceforge.net/"
SRC_URI="mirror://sourceforge/crystal/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="3ds debug mikmod mng oggvorbis openal truetype"

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
	>=dev-lang/perl-5.6.1
	=media-libs/cal3d-0.11.0_pre*"

DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	dev-util/jam
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/${PN}"

CRYSTAL_PREFIX="/opt/crystal"

src_compile() {
	# Disabling python entirely, some parts don't build
	#use python || \
	my_conf="${my_conf} --without-python"

	use debug && my_conf="${my_conf} --enable-debug"

	# Clear out the maya2spr stuff.. it fails to build properly (left as example)
	#sed 's/SubInclude TOP apps import maya2spr ;//' -i apps/import/Jamfile

	./configure --prefix=${CRYSTAL_PREFIX} ${my_conf}

	jam all || die "compile failed"
	jam cs-config || die "compile failed"
}

src_install() {
	jam -sprefix="${D}"${CRYSTAL_PREFIX} install

	# Fix cs-config file to point to ${CRYSTAL_PREFIX}
	sed -i 's/^CRYSTAL=.*/CRYSTAL=\/opt\/crystal/' "${D}/${CRYSTAL_PREFIX}/bin/cs-config"

	# Symlink cs-config into /usr/bin
	dodir /usr/bin
	dosym ${CRYSTAL_PREFIX}/bin/cs-config /usr/bin/cs-config

	# Make sure these files dont have $D
	dosed ${CRYSTAL_PREFIX}/{bin/cs-config,etc/crystalspace/vfs.cfg}

	# Fix perms so everyone can read these
	find "${D}"/${CRYSTAL_PREFIX} -type f -exec chmod a+r '{}' \;
	find "${D}"/${CRYSTAL_PREFIX} -type d -exec chmod a+rx '{}' \;
	chmod a+rx "${D}"/${CRYSTAL_PREFIX}/bin/*

	dodir /etc/env.d
	echo "CRYSTAL=\"${CRYSTAL_PREFIX}\"" > 90crystalspace
	doenvd 90crystalspace
}
