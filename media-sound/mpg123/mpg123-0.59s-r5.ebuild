# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-0.59s-r5.ebuild,v 1.3 2004/10/21 20:57:19 eradicator Exp $

IUSE="mmx 3dnow esd nas oss"

inherit eutils

PATCH_VER=1.0
S="${WORKDIR}/${PN}"

DESCRIPTION="Real Time mp3 player"
HOMEPAGE="http://www.mpg123.de/"
SRC_URI="http://www.mpg123.de/mpg123/${PN}-pre${PV}.tar.gz
	 http://dev.gentoo.org/~eradicator/${PN}/${P}-gentoo-${PATCH_VER}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ia64 amd64 ~ppc sparc ~alpha ~hppa ~mips ~ppc64"

RDEPEND="virtual/libc
	 esd? ( media-sound/esound )
	 nas? ( media-libs/nas )"

# alsa-1 b0rks and it's not a simple fix
#	 alsa? ( media-libs/alsa-lib )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

PROVIDE="virtual/mpg123"

#PATCHDIR="${WORKDIR}/patches"
PATCHDIR="/home/jeremy/gentoo/mpg123/patches"

src_unpack() {
	unpack ${A}

	cd ${S}
        EPATCH_SUFFIX="patch"
	epatch ${PATCHDIR}
}

src_compile() {
	mkdir gentoo-bin

	# The last one in $styles is the default
	local styles

	use nas && styles="${styles} -nas"
	use oss && styles="${styles} -generic"

	case $ARCH in
		ppc*)
			use esd && styles="${styles} -ppc-esd"
			use oss && styles="${styles} -ppc"

			[ -z "${styles}" ] && styles="-ppc"
			;;
		x86)
			use esd && styles="${styles} -esd"
			use esd && use 3dnow && styles="${styles} -3dnow-esd"
			use oss && styles="${styles} -i486"
			use oss && use mmx && styles="${styles} -mmx"
			use oss && use 3dnow && styles="${styles} -3dnow"
			# use alsa && styles="${styles} -alsa"
			# use alsa && use 3dnow && styles="${styles} -3dnow-alsa"

			[ -z "${styles}" ] && styles="-generic"
			;;
		sparc*)
			use esd && styles="${styles} -sparc-esd"
			styles="${styles} -sparc"
			;;
		amd64)
			use esd && styles="${styles} -x86_64-esd"
			use oss && styles="${styles} -x86_64"
			# use alsa && styles="${styles} -x86_64-alsa"

			[ -z "${styles}" ] && styles="-x86_64"
			;;
		alpha)
			use esd && styles="${styles} -alpha-esd"
			use oss && styles="${styles} -alpha"
			# use alsa && styles="${styles} -alpha-alsa"

			[ -z "${styles}" ] && styles="-generic"
			;;
		mips|hppa)
			# use alsa && styles="${styles} -mips-alsa"

			[ -z "${styles}" ] && styles="-generic"
			;;
		*)
			eerror "No support has been added for your architecture."
			exit 1
			;;
	esac

	for style in ${styles};
	do
		make clean linux${style} CFLAGS="${CFLAGS}" || die
		mv mpg123 gentoo-bin/mpg123${style}
		[ -L "gentoo-bin/mpg123" ] && rm gentoo-bin/mpg123
		ln -s mpg123${style} gentoo-bin/mpg123
	done
}

src_install() {
	dodir /usr
	cp -dR gentoo-bin ${D}/usr/bin
	doman mpg123.1
	dodoc BENCHMARKING BUGS CHANGES COPYING JUKEBOX README* TODO
}
