# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.4.0_rc2.ebuild,v 1.1 2005/04/05 20:19:47 agriffis Exp $

inherit flag-o-matic

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

IUSE="ipv6"

DEPEND="virtual/libc >=sys-apps/sed-4"

src_compile() {
	econf $(use_enable ipv6) || die
	emake || die
}

src_install () {
	einstall || die

	# move netserver into sbin as we had it before 2.4 was released with its
	# autoconf goodness
	dodir /usr/sbin
	mv ${D}/usr/{bin,sbin}/netserver || die

	# init.d / conf.d
	exeinto /etc/init.d ; newexe ${FILESDIR}/${PN}-2.2-init netperf
	insinto /etc/conf.d ; newins ${FILESDIR}/${PN}-2.2-conf netperf

	# documentation and example scripts
	dodoc AUTHORS ChangeLog COPYING NEWS README Release_Notes doc/netperf.pdf
	mkdir ${D}/usr/share/doc/${PF}/examples
	mv ${D}/usr/bin/*_script ${D}//usr/share/doc/${PF}/examples
}
