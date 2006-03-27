# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.4.0-r1.ebuild,v 1.1 2006/03/27 01:27:51 jokey Exp $

inherit flag-o-matic autotools

MY_P=${P/_rc/-rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Network performance benchmark including tests for TCP, UDP, sockets, ATM and more."
if [[ ${PV} == *_* ]]; then
	SRC_URI="ftp://ftp.cup.hp.com/dist/networking/benchmarks/netperf/experimental/${MY_P}.tar.gz"
else
	SRC_URI="ftp://ftp.cup.hp.com/dist/networking/benchmarks/netperf/${MY_P}.tar.gz"
fi
HOMEPAGE="http://www.netperf.org/"
LICENSE="netperf"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ia64 ~alpha ~amd64 ~ppc64 ~ppc ~ppc-macos"

IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc41.patch
	eautoconf
}

src_install () {
	einstall || die

	# move netserver into sbin as we had it before 2.4 was released with its
	# autoconf goodness
	dodir /usr/sbin
	mv ${D}/usr/{bin,sbin}/netserver || die

	# init.d / conf.d
	newinitd ${FILESDIR}/${PN}-2.2-init netperf
	newconfd ${FILESDIR}/${PN}-2.2-conf netperf

	# documentation and example scripts
	dodoc AUTHORS ChangeLog COPYING NEWS README Release_Notes doc/netperf.pdf
	dodir /usr/share/doc/${PF}/examples
	mv ${D}/usr/bin/*_script ${D}/usr/share/doc/${PF}/examples
}
