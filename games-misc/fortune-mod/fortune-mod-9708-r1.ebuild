# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod/fortune-mod-9708-r1.ebuild,v 1.3 2004/02/20 06:43:58 mr_bones_ Exp $

inherit eutils

#The original (http://www.progsoc.uts.edu.au/~dbugger/hacks/hacks.html) is dead
# but the guy setup his 'perm' home with LSM (http://lsm.execpc.com/)
DESCRIPTION="The notorious fortune program"
HOMEPAGE="ftp://sunsite.unc.edu/pub/Linux/games/amusements/fortune/"
SRC_URI="http://www.ibiblio.org/pub/Linux/games/amusements/fortune/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE="offensive"

DEPEND="virtual/glibc"

[ `use offensive` ] && off=1 || off=0

pkg_setup() {
	einfo "By default the fortune ebuild does not include 'offensive' fortunes."
	einfo "If you wish to enable this functionality, you must manually edit the"
	einfo "ebuild. The comments inside are self explainatory."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile.patch
	epatch ${FILESDIR}/${PV}-ppc-rot.patch
}

src_compile() {
	emake \
		OFFENSIVE=${off} \
		OPTCFLAGS="${CFLAGS}" \
		|| die
}

src_install() {
	make \
		OFFENSIVE=${off} \
		OPTCFLAGS="${CFLAGS}" \
		DESTDIR=${D} \
		install \
		|| die

	dosed /usr/share/man/man6/fortune.6

	dodoc ChangeLog INDEX INSTALL Notes README TODO
}
