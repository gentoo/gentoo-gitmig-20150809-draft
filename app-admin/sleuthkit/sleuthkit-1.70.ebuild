# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sleuthkit/sleuthkit-1.70.ebuild,v 1.1 2004/07/19 07:03:23 dragonheart Exp $

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2 IBM"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~s390"
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
		emake -e no-perl sorter mactime || die "make failed"
}

# This is broken - bug report logged upstream. Maybe next version.
# The condition may need to check the output.
#
# Also this isn't a true test as it only checks if the files compile.
#
#src_test() {
#	./check-install || die "test failed"
#}

src_install() {
	dobin bin/* || die
	dodoc docs/*
	docinto tct.docs
	dodoc tct.docs/*
	insinto /usr/share/sorter
	doins share/sorter/*
	doman man/man1/*
}
