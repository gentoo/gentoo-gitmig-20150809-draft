# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iputils/iputils-021109-r3.ebuild,v 1.18 2005/01/04 23:41:43 vapier Exp $

inherit flag-o-matic gnuconfig eutils toolchain-funcs

DESCRIPTION="Network monitoring tools including ping and ping6"
HOMEPAGE="ftp://ftp.inr.ac.ru/ip-routing"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${PN}-ss${PV}-try.tar.bz2
	http://ftp.iasi.roedu.net/mirrors/ftp.inr.ac.ru/ip-routing/${PN}-ss${PV}-try.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="static ipv6 uclibc doc"

DEPEND="virtual/libc
	virtual/os-headers
	sys-devel/bison
	sys-devel/flex
	dev-libs/openssl
	sys-devel/autoconf
	doc? (
		app-text/openjade
		dev-perl/SGMLSpm
		app-text/docbook-sgml-dtd
		app-text/docbook-sgml-utils
	)"
RDEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/iputils-021109-pfkey.patch include-glibc/net/pfkeyv2.h
	use static && append-ldflags -static

	epatch ${FILESDIR}/${PV}-gcc34.patch
	epatch ${FILESDIR}/${PV}-no-pfkey-search.patch
	epatch ${FILESDIR}/${PV}-ipg-linux-2.6.patch #71756
	epatch ${FILESDIR}/${PV}-syserror.patch
	epatch ${FILESDIR}/${PV}-uclibc-no-ether_ntohost.patch

	# make iputils work with newer glibc snapshots
	epatch ${FILESDIR}/${P}-linux-udp-header.patch

	sed -i \
		-e "/^CCOPT=/s:-O2:${CFLAGS}:" \
		-e "/^CC=/s:.*::" \
		Makefile \
		|| die "sed Makefile opts failed"
	sed -i \
		-e '/^all:/s:check-kernel::' \
		-e 's:-I$(KERNEL_INCLUDE)::' \
		-e 's:-I/usr/src/linux/include::' \
		Makefile libipsec/Makefile setkey/Makefile \
		|| die "sed /usr/include failed"
	use ipv6 || sed -i -e 's:IPV6_TARGETS=:#IPV6_TARGETS=:' Makefile

	sed -i "s:-ll:-lfl ${LDFLAGS}:" setkey/Makefile || die "sed setkey failed"

	sed -i 's:yacc:bison -y:' libipsec/Makefile #59191
}

src_compile() {
	tc-export CC AR

	# We have to make sure ipsec.h is usuable #67569
	echo '#include <linux/ipsec.h>' > "${T}"/test.c
	if ${CC} -c "${T}"/test.c >&/dev/null ; then
		cd ${S}/libipsec
		emake || die "libipsec failed"

		cd ${S}/setkey
		emake || die "setkey failed"
	fi

	cd ${S}
	emake || die "make main failed"

	# We include the extra check for docbook2html 
	# because when we emerge from a stage1/stage2, 
	# it may not exist #23156
	if use doc && type -p docbook2html ; then
		make html || die
	fi
	make man || die "make man failed"
}

src_install() {
	into /
	dobin ping
	use ipv6 && dobin ping6
	dosbin arping
	into /usr
	[[ -x setkey/setkey ]] && dobin setkey/setkey
	dosbin tracepath
	use ipv6 && dosbin trace{path,route}6
	dosbin clockdiff rarpd rdisc ipg tftpd

	fperms 4711 /bin/ping
	use ipv6 && fperms 4711 /bin/ping6

	dodoc INSTALL RELNOTES

	use ipv6 || rm doc/*6.8
	doman doc/*.8

	use doc && dohtml doc/*.html
}
