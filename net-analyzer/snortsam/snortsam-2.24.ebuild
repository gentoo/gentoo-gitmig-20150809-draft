# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortsam/snortsam-2.24.ebuild,v 1.4 2005/01/12 08:17:59 dragonheart Exp $

DESCRIPTION="Snort plugin that allows automated blocking of IP addresses on several firewalls"
HOMEPAGE="http://www.snortsam.net/"
SRC_URI="http://www.snortsam.net/files/snortsam-v2_multi-threaded/${PN}-src-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64 ppc"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	sed -i "s: -O2 : ${CFLAGS} :" makesnortsam.sh
	./makesnortsam.sh || die
}

src_install() {
	dobin snortsam
	dodoc AUTHORS BUGS CREDITS FAQ INSTALL NEWS README* TODO
}

pkg_postinst() {
	einfo "To use snortsam with snort, you'll have to compile snort with"
	einfo "the snortsam patch - remerge snort with the snortsam useflag."
	einfo ""
	einfo "Read the INSTALL file to configure snort for snortsam, and"
	einfo "configure snortsam for your particular firewall."
}


