# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/crystalspace/crystalspace-20040604.ebuild,v 1.2 2004/06/16 20:09:53 mr_bones_ Exp $

DESCRIPTION="portable 3D Game Development Kit written in C++"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.bz2"
HOMEPAGE="http://crystal.sourceforge.net/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="oggvorbis mikmod openal truetype 3ds mng zlib"

RDEPEND=">=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b
	mng? ( media-libs/libmng )
	mikmod? ( media-libs/libmikmod )
	3ds? ( media-libs/lib3ds )
	truetype? ( >=media-libs/freetype-2.0 )
	openal? ( media-libs/openal )
	zlib? ( sys-libs/zlib )
	oggvorbis? (
		>=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	dev-games/ode
	>=dev-lang/perl-5.6.1
	!dev-games/crystalspace-cvs"
DEPEND="${RDEPEND}
	dev-util/jam
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/CS"

CRYSTAL_PREFIX="/opt/crystal"

src_compile() {
	./configure --prefix=${CRYSTAL_PREFIX} || die
	jam all || die "Cannot compile"
#	emake all || die
}

src_install() {
	#mv ${S}/Jamconfig ${S}/Jamconfig_orig
	#sed s%/opt/crystal%${D}/opt/crystal% ${S}/Jamconfig_orig > ${S}/Jamconfig

	jam -sprefix=${D}${CRYSTAL_PREFIX} install

	# symlink for cs-config
	dodir /usr/bin
	dosym ${CRYSTAL_PREFIX}/bin/cs-config /usr/bin/cs-config

	# fix path in cs-config and vfs.cfg
	mv ${D}/opt/crystal/bin/cs-config ${D}/opt/crystal/bin/cs-config_orig
#	mv ${D}/opt/crystal/etc/crystal/vfs.cfg ${D}/opt/crystal/etc/crystal/vfs.cfg_orig
	sed s%${D}%% ${D}/opt/crystal/bin/cs-config_orig > ${D}/opt/crystal/bin/cs-config
#	sed s%${D}%% ${D}/opt/crystal/etc/crystal/vfs.cfg_orig > ${D}/opt/crystal/etc/crystal/vfs.cfg
	# the -sprefix=... fixes cs-config but not vfs.cfg

	find ${D}/${CRYSTAL_PREFIX} -type f -exec chmod a+r '{}' \;
	find ${D}/${CRYSTAL_PREFIX} -type d -exec chmod a+rx '{}' \;
	chmod a+rx ${D}/${CRYSTAL_PREFIX}/{bin,lib}/*

	dodir /etc/env.d
	echo "CRYSTAL=\"${CRYSTAL_PREFIX}\"" > ${D}/etc/env.d/90crystalspace
}
