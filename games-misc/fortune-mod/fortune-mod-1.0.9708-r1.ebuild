# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod/fortune-mod-1.0.9708-r1.ebuild,v 1.4 2004/06/25 03:21:02 agriffis Exp $

inherit eutils

MY_P="${PN}-${P##*.}"
#The original (http://www.progsoc.uts.edu.au/~dbugger/hacks/hacks.html) is dead
# but the guy setup his 'perm' home with LSM (http://lsm.execpc.com/)
DESCRIPTION="The notorious fortune program"
HOMEPAGE="ftp://sunsite.unc.edu/pub/Linux/games/amusements/fortune/"
SRC_URI="http://www.ibiblio.org/pub/Linux/games/amusements/fortune/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE="offensive"

DEPEND="virtual/glibc"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	einfo "By default the fortune ebuild does not include 'offensive' fortunes."
	einfo "If you wish to enable this functionality, you must add the 'offensive' local"
	einfo "USE flag to your make.conf."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/9708-Makefile.patch"
	epatch "${FILESDIR}/9708-ppc-rot.patch"
}

src_compile() {
	local off=0

	use offensive && off=1
	emake \
		OFFENSIVE=${off} \
		OPTCFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	local off=0

	use offensive && off=1
	make \
		OFFENSIVE=${off} \
		OPTCFLAGS="${CFLAGS}" \
		DESTDIR="${D}" \
		install \
		|| die "make install failed"

	dosed /usr/share/man/man6/fortune.6

	dodoc ChangeLog INDEX INSTALL Notes README TODO
}
