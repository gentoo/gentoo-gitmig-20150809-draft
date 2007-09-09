# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortsam/snortsam-2.50-r1.ebuild,v 1.6 2007/09/09 15:34:09 josejx Exp $

inherit eutils

MY_P="${PN}-src-${PV}"
DESCRIPTION="Snort plugin that allows automated blocking of IP addresses on several firewalls"
HOMEPAGE="http://www.snortsam.net/"
SRC_URI="http://www.snortsam.net/files/snortsam/${MY_P}.tar.gz
	mirror://gentoo/${PN}-2.50-ciscoacl.diff.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 x86"
IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.29-no-ugly----lines.diff
	# bug 155955, ciscoacl segfaults with gcc-4.1.1
	epatch "${DISTDIR}"/${PN}-2.50-ciscoacl.diff.bz2
}

src_compile() {
	sed -i "s: -O2 : ${CFLAGS} :" makesnortsam.sh || die "sed failed"
	sh makesnortsam.sh || die "makesnortsam.sh failed"
}

src_install() {
	find "${S}" -type d -name CVS -exec rm -rf {} \;
	find "${S}" -type f -name "*.asc" -exec rm -f {} \;
	dobin snortsam || die "dobin failed"
	dodoc docs/* conf/*
}

pkg_postinst() {
	elog
	elog "To use snortsam with snort, you'll have to compile snort with USE=snortsam."
	elog "Read the INSTALL file to configure snort for snortsam, and configure"
	elog "snortsam for your particular firewall."
	elog

}
