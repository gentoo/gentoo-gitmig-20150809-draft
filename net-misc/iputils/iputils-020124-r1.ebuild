# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/iputils/iputils-020124-r1.ebuild,v 1.12 2003/09/05 22:01:48 msterret Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="Network monitoring tools including ping and ping6"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${PN}-ss${PV}.tar.gz"
HOMEPAGE="ftp://ftp.inr.ac.ru/ip-routing"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc hppa mips"

DEPEND="virtual/glibc
	virtual/os-headers
	app-text/openjade
	dev-perl/SGMLSpm
	app-text/docbook-sgml-dtd
	app-text/docbook-sgml-utils"

src_compile() {
	make KERNEL_INCLUDE="/usr/include" || die
	make html || die
	make man || die
}

src_install () {
	into /
	dobin ping ping6
	dosbin arping
	into /usr
	dobin tracepath tracepath6 traceroute6
	dosbin clockdiff rarpd rdisc ipg tftpd

	fperms 4755 /bin/ping /bin/ping6 /usr/bin/tracepath \
		/usr/bin/tracepath6 /usr/bin/traceroute6

	dodoc INSTALL RELNOTES
	doman doc/*.8
}
