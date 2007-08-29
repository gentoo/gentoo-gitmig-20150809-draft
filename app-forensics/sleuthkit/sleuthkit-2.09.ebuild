# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/sleuthkit/sleuthkit-2.09.ebuild,v 1.1 2007/08/29 14:49:32 falco Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz
	dbtool? ( mirror://gentoo/${P}_dbtool.patch.bz2 ) "

LICENSE="GPL-2 IBM"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="dbtool"

RDEPEND="dev-perl/DateManip"

src_unpack() {
	unpack ${A}
	cd ${S}
	use dbtool && epatch "${WORKDIR}/${P}_dbtool.patch"
	epatch "${FILESDIR}/${PN}-makefiles_fix.patch"
	epatch "${FILESDIR}/${PN}-fscheck.c_fix.patch"
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
	if has_version 'sys-apps/dstat' ; then
		mv ${D}/usr/bin/dstat ${D}/usr/bin/dstat-dsk
		echo
		ewarn "You are installing sleuthkit while you have sys-apps/dstat"
		ewarn "already installed."
		ewarn "app-forensics/sleuthkit provides /usr/bin/dstat which is a tool"
		ewarn "that displays details of a data structure, while sys-apps/dstat"
		ewarn "provides /usr/bin/dstat as a system statistics tool."
		echo
		ewarn "The Sleuth Kit dstat binary has been renamed to"
		ewarn "/usr/bin/dstat-tsk (see bug 131268). This may cause trouble with"
		ewarn "applications using sleuthkit such as Autopsy. You may prefer"
		ewarn "to unmerge sys-apps/dstat and re-emerge app-forensics/sleuthkit."
		echo
	fi
	dodoc docs/*.txt
	docinto api-doc
	dohtml docs/api-doc/*
	insinto /usr/share/sorter
	doins share/sorter/*
	doman man/man1/*
}
