# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/lincity/lincity-1.11a-r1.ebuild,v 1.2 2004/01/23 00:47:34 mr_bones_ Exp $

MY_P=${P/a/-patch1}
S=${WORKDIR}/${MY_P}
DESCRIPTION="city/country simulation game for X and Linux SVGALib"
SRC_URI="http://www-personal.engin.umich.edu/~gsharp/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.floot.demon.co.uk/lincity.html"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE="X svga"

DEPEND="virtual/glibc
	svga? ( media-libs/svgalib )
	X? ( virtual/x11 )
	|| ( svga? ( ) X? ( ) virtual/x11 )"

src_unpack() {
	unpack lincity-1.11-patch1.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/lincity-1.11a-gcc3.patch
}

src_compile() {
	# we cant do emake || die because it will always fail ... stupid man pages
	if [ "`use X`" ] || [ -z "`use X``use svga`" ] ; then
		emake xlincity EXTRA_OPTS="${CFLAGS}"
		[ -x ${S}/xlincity ] || die "emake failed"
	fi
	if [ "`use svga`" ] ; then
		emake lincity EXTRA_OPTS="${CFLAGS}"
		[ -x ${S}/lincity ] || die "emake failed"
	fi
}

src_install() {
	make LC_BINDIR=${D}usr/bin LC_LIBDIR=${D}usr/lib/lincity \
		LC_MANDIR={D}/usr/share/man  install || die

	dodoc BUGS CHANGES COPYING COPYRIGHT FAQ README README.INSTALL \
	README.aix README.freebsd README.irix README.profiling \
	README.sco README.win32

	use svga || dosym /usr/bin/xlincity /usr/bin/lincity
}
