# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-0.59s-r1.ebuild,v 1.5 2004/01/12 00:21:56 agriffis Exp $

inherit eutils

S=${WORKDIR}/mpg123
DESCRIPTION="Real Time mp3 player"
HOMEPAGE="http://www.mpg123.de/"
SRC_URI="http://www.mpg123.de/mpg123/${PN}-pre${PV}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ia64 ~amd64 ~ppc ~sparc alpha ~hppa ~mips ~arm"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

src_unpack () {
	unpack ${A}
	cd ${S}

	# Apply security fix
	epatch ${FILESDIR}/${P}-security.diff
	epatch ${FILESDIR}/${PV}-generic.patch
	use amd64 && epatch ${FILESDIR}/mpg123-0.59s-amd64.patch
	sed -i \
		-e "s:-O2 -m486:${CFLAGS}:" \
		-e "s:-O2 -mcpu=ppc:${CFLAGS}:g" Makefile
}

src_compile() {
	local MAKEOPT=""
	local MAKESTYLE=""

	SYSTEM_ARCH=`echo $ARCH |\
		sed -e s/[i]*.86/i386/ \
			-e s/sun.*/sparc/ \
			-e s/arm.*/arm/ \
			-e s/sa110/arm/`

	if [ -z "$SYSTEM_ARCH" ]
	then
		SYSTEM_ARCH=`uname -m |\
		sed -e s/[i]*.86/i386/ -e s/arm.*/arm/ -e s/sa110/arm/`
	fi

	case $SYSTEM_ARCH in
		ppc)
			MAKESTYLE="-ppc";;
		i386)
			if [ -z "use mmx" ]
			then
				MAKESTYLE="-mmx"
			else
				MAKESTYLE="-i486"
			fi;;
		sparc64)
			MAKESTYLE="-sparc";;
		sparc)
			MAKESTYLE="-sparc";;
		amd64|x86_64)
			MAKESTYLE="-x86_64";;
		alpha)
			MAKESTYLE="-alpha";;
		arm)
			;;
		hppa)
			MAKESTYLE="-generic";;
	esac

	make linux${MAKESTYLE}${MAKEOPT} || die
}

src_install () {
	into /usr
	dobin mpg123
	doman mpg123.1
	dodoc BENCHMARKING BUGS CHANGES COPYING JUKEBOX README* TODO
}

