# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.4.2-r1.ebuild,v 1.3 2007/03/22 14:09:14 gustavoz Exp $

WANT_AUTOCONF="latest"
inherit eutils flag-o-matic autotools

MY_P=${P/_rc/-rc}

DESCRIPTION="Network performance benchmark including tests for TCP, UDP, sockets, ATM and more."
#SRC_URI="ftp://ftp.netperf.org/netperf/experimental/${MY_P}.tar.gz"
SRC_URI="ftp://ftp.netperf.org/netperf/${MY_P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~ppc64 sparc x86"

HOMEPAGE="http://www.netperf.org/"
LICENSE="netperf"
SLOT="0"
IUSE=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.4.0-gcc41.patch
	epatch ${FILESDIR}/${PN}-fix-scripts.patch
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
	#Scripts no longer get installed by einstall
	cp doc/examples/*_script ${D}/usr/share/doc/${PF}/examples
}
