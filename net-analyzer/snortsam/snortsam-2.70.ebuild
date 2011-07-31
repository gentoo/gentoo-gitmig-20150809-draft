# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortsam/snortsam-2.70.ebuild,v 1.1 2011/07/31 12:56:46 patrick Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_P="${PN}-src-${PV}"
DESCRIPTION="Snort plugin that allows automated blocking of IP addresses on several firewalls"
HOMEPAGE="http://www.snortsam.net/"
SRC_URI="http://www.snortsam.net/files/snortsam/${MY_P}.tar.gz
	mirror://gentoo/${PN}-2.50-ciscoacl.diff.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i -e "s:sbin/functions.sh:etc/init.d/functions.sh:" \
			-e "s: -O2 : ${CFLAGS} :" \
			-e "s:gcc :$(tc-getCC) :" \
			-e "s:\( -o ../snortsam\): ${LDFLAGS}\1:" makesnortsam.sh || die "sed failed"
	find "${S}" -depth -type d -name CVS -exec rm -rf \{\} \;
}

src_compile() {
	sh makesnortsam.sh || die "makesnortsam.sh failed"
}

src_install() {
	dobin snortsam || die "dobin failed"
	find "${S}" -depth -type f -name "*.asc" -exec rm -f {} \;
	dodoc docs/* conf/*
}

pkg_postinst() {
	elog
	elog "To use snortsam with snort, you'll have to compile snort with USE=snortsam."
	elog "Read the INSTALL file to configure snort for snortsam, and configure"
	elog "snortsam for your particular firewall."
	elog
}
