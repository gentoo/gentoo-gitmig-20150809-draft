# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/sleuthkit/sleuthkit-1.69.ebuild,v 1.1 2004/09/12 06:35:23 dragonheart Exp $

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz"

LICENSE="GPL-2 IBM"
SLOT="0"
KEYWORDS="x86 ~ppc sparc hppa s390"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/DateManip
	virtual/libc
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
	env -u CFLAGS \
		make -e no-perl sorter mactime || die "make failed"
}

src_install() {
	dobin bin/* || die
	dodoc CHANGES README docs/*
	docinto tct.docs
	dodoc tct.docs/*
	insinto /usr/share/sorter
	doins share/sorter/*
	doman man/man1/*
}
