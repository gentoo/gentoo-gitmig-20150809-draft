# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yodl/yodl-1.31.18.ebuild,v 1.7 2004/08/05 22:01:03 slarti Exp $

inherit eutils

HOMEPAGE="http://www.xs4all.nl/~jantien/yodl/"
SRC_URI="ftp://ftp.lilypond.org/pub/yodl/development/${P}.tar.gz"
DESCRIPTION="Yet oneOther Document Language"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc ~sparc alpha ~mips ~amd64"

DEPEND="sys-devel/bison
	sys-devel/flex
	sys-apps/diffutils
	sys-apps/groff
	dev-lang/python
	sys-apps/texinfo"

RDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S} || die "pre-patch chdir failed"
	epatch "${FILESDIR}/bison-configure.patch"
	#use ia64 && epatch "${FILESDIR}/${P}-compile-fix-ia64.patch"
	epatch "${FILESDIR}/${P}-debian.patch"
}

src_compile() {
	# Avoid a makefile bug if this var is already defined in the environment.
	unset NAME

	# The auto-dependencies break if ccache is used (for the first compile).
	export CCACHE_DISABLE=yes
	econf --datadir=/usr/share/yodl || die "econf failed"
	make || die "make failed"

	cd Documentation
	make info || die "make info failed"
}

src_install() {
	unset NAME

	make prefix="${D}/usr" \
		datadir="${D}/usr/share/yodl" \
		mandir="${D}/usr/share/man" \
		infodir="${D}/usr/share/info" \
		install || die

	doinfo Documentation/out/*.info*
	dodoc ANNOUNCE-1.22 ChangeLog-1.22 CHANGES TODO VERSION *.txt
}
