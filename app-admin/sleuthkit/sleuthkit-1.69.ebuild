# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sleuthkit/sleuthkit-1.69.ebuild,v 1.6 2004/06/05 23:32:41 dragonheart Exp $

DESCRIPTION="A collection of file system and media management forensic analysis tools"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
RESTRICT="nomirror"
IUSE=""
KEYWORDS="x86 ~sparc s390 ~ppc hppa"
LICENSE="GPL-2 IBM"
SLOT="0"

RDEPEND="dev-lang/perl
	dev-perl/DateManip
	virtual/glibc
	sys-libs/zlib"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/gcc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '63,69d' src/timeline/config-perl
	sed -i 's:`cd ../..; pwd`:/usr:' src/sorter/install
}

src_compile() {
	export OPT="${CFLAGS}"
	unset CFLAGS
	make -e no-perl sorter mactime || die "make failed"
}

src_install() {
	dobin bin/*
	dodoc CHANGES README docs/*
	docinto tct.docs
	dodoc tct.docs/*
	insinto /usr/share/sorter
	doins share/sorter/*
	doman man/man1/*
}
