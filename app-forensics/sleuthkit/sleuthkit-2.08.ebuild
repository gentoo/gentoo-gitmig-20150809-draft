# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/sleuthkit/sleuthkit-2.08.ebuild,v 1.1 2007/04/11 22:20:06 falco Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz
	dbtool? ( mirror://gentoo/${P}_dbtool.patch.bz2 ) "

LICENSE="GPL-2 IBM"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="dbtool"

RDEPEND="dev-perl/DateManip
	!sys-apps/dstat"

src_unpack() {
	unpack ${A}
	use dbtool && epatch "${P}_dbtool.patch"
	epatch "${FILESDIR}/${PN}-makefiles_fix.patch"
	epatch "${FILESDIR}/${PN}-fscheck.c_fix.patch"
	cd ${S}
	sed -i '63,69d' src/timeline/config-perl || die "sed config-perl failed"
	sed -i 's:`cd ../..; pwd`:/usr:' src/sorter/install \
		|| die "sed install failed"
}

src_compile() {
	export CC="$(tc-getCC)" OPT="${CFLAGS}"
	# Targets: this is so it doesn't remake sys-apps/file
	# -j1: it really doesn't compile well with -j2 or more,
	# even after having fixed the Makefiles... :(
	env -u CFLAGS \
		emake -j1 -e bin no-perl sorter mactime || die "make failed"
}

src_install() {
	dobin bin/* || die "dobin failed"
	dodoc docs/*
	docinto api-doc
	dohtml docs/api-doc/*
	insinto /usr/share/sorter
	doins share/sorter/*
	doman man/man1/*
}
