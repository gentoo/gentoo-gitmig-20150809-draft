# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-0.59s-r1.ebuild,v 1.9 2004/02/15 20:39:08 agriffis Exp $

inherit eutils

S=${WORKDIR}/mpg123
DESCRIPTION="Real Time mp3 player"
HOMEPAGE="http://www.mpg123.de/"
SRC_URI="http://www.mpg123.de/mpg123/${PN}-pre${PV}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ia64 ~amd64 ~ppc sparc alpha ~hppa ~mips"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

src_unpack () {
	unpack ${A} && cd ${S} || die "unpack failed"

	# Apply security fix
	epatch ${FILESDIR}/${P}-security.diff

	# Add linux-generic target
	epatch ${FILESDIR}/${PV}-generic.patch

	# Always apply this patch, even though it's particularly for
	# amd64.  It's good to understand the distinction between int and
	# long: ANSI says that int should be 32-bits, long should be the
	# native size of the CPU (usually the same as a pointer).
	epatch ${FILESDIR}/mpg123-0.59s-amd64.patch

	# Don't force gcc since icc/ccc might be possible
	sed -i -e "s|CC=gcc||" Makefile

	# Fix a glitch in the ppc-related section of the Makefile
	sed -i -e "s:-mcpu=ppc::" Makefile
}

src_compile() {
	local style=""

	case $ARCH in
		ppc)
			style="-ppc";;
		x86)
			use mmx && style="-mmx" || style="-i486";;
		sparc*)
			style="-sparc";;
		amd64|x86_64)
			style="-x86_64";;
		alpha)
			style="-alpha";;
		arm|hppa|ia64)
			style="-generic";;
	esac

	make linux${style} RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install () {
	into /usr
	dobin mpg123
	doman mpg123.1
	dodoc BENCHMARKING BUGS CHANGES COPYING JUKEBOX README* TODO
}

