# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/sleuthkit/sleuthkit-1.73.ebuild,v 1.2 2004/11/21 17:42:28 sekretarz Exp $

inherit toolchain-funcs

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz"

LICENSE="GPL-2 IBM"
SLOT="0"
KEYWORDS="~arm ~hppa ~ppc ~s390 ~sparc ~x86 ~amd64"
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
	sed -i '63,69d' src/timeline/config-perl || die "sed config-perl failed"
	sed -i 's:`cd ../..; pwd`:/usr:' src/sorter/install \
		|| die "sed install failed"
}

src_compile() {
	export CC="$(tc-getCC)" OPT="${CFLAGS}"
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
#	if ! hasq userpriv FEATURES
#		icat $(ls -i README.txt | cut -f1 -d ' ') (mount point of README.txt) | diff - README.txt || die "icat test failed"
#	fi #TODO more work on later
#}

src_install() {
	dobin bin/* || die "dobin failed"
	dodoc docs/*
	docinto tct.docs
	dodoc tct.docs/*
	insinto /usr/share/sorter
	doins share/sorter/*
	doman man/man1/*
}
