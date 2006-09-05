# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/sleuthkit/sleuthkit-2.03.ebuild,v 1.6 2006/09/05 20:42:01 gustavoz Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz
		mirror://gentoo/${P}_dbtool.patch.bz2"

LICENSE="GPL-2 IBM"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ~s390 sparc x86"
IUSE=""

RDEPEND="dev-perl/DateManip"

src_unpack() {
	unpack "${P}.tar.gz"
	#unpack "${A}"
	einfo 'unpacked'
	#epatch "${P}_dbtool.patch"
	epatch "${DISTDIR}/${P}_dbtool.patch.bz2"
	cd ${S}
	sed -i '63,69d' src/timeline/config-perl || die "sed config-perl failed"
	sed -i 's:`cd ../..; pwd`:/usr:' src/sorter/install \
#		|| die "sed install failed"
}

src_compile() {
	export CC="$(tc-getCC)" OPT="${CFLAGS}"
	# this is so it doesn't remake sys-apps/file
	env -u CFLAGS \
		emake -e no-perl sorter mactime || die "make failed"
}

# This is broken - bug report logged upstream. Maybe next version.
# The condition may need to check the output.
#
# Also this isn't a true test as it only checks if the files compile.
#
src_test() {
	./check-install || die "test failed"
	einfo '"file missing" is normal'
	#if ! hasq userpriv FEATURES
	#	icat $(ls -i README.txt | cut -f1 -d ' ') (mount point of README.txt) | diff - README.txt || die "icat test failed"
	#fi #TODO more work on later
}

src_install() {
	dobin bin/* || die "dobin failed"
	dodoc docs/*
	insinto /usr/share/sorter
	doins share/sorter/*
	doman man/man1/*
}
