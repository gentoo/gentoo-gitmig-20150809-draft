# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iputils/iputils-020927.ebuild,v 1.7 2003/06/20 18:26:26 avenj Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="Network monitoring tools including ping and ping6"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${PN}-ss${PV}.tar.gz"
HOMEPAGE="ftp://ftp.inr.ac.ru/ip-routing"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~sparc ~alpha ~ppc hppa ~mips"
#IUSE="doc"
IUSE=""

DEPEND="virtual/glibc
	virtual/os-headers"
#	doc? ( app-text/openjade
#		dev-perl/SGMLSpm
#		app-text/docbook-sgml-dtd
#		app-text/docbook-sgml-utils )

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	mv Makefile Makefile.orig
	sed "27s:-O2:${CFLAGS}:" Makefile.orig >Makefile
}

src_compile() {
	make KERNEL_INCLUDE="/usr/include" || die
#	if [ "`use doc`" ]; then
#		make html || die
#	fi
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

#	if [ "`use doc`" ]; then
#		dohtml doc/*.html
#	fi
}
