# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iputils/iputils-021109-r1.ebuild,v 1.9 2004/04/07 05:39:29 vapier Exp $

inherit flag-o-matic gcc gnuconfig

DESCRIPTION="Network monitoring tools including ping and ping6"
HOMEPAGE="ftp://ftp.inr.ac.ru/ip-routing"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${PN}-ss${PV}-try.tar.bz2
	http://ftp.iasi.roedu.net/mirrors/ftp.inr.ac.ru/ip-routing/${PN}-ss${PV}-try.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ppc64 s390"
IUSE="static ipv6" #doc

DEPEND="virtual/glibc
	virtual/os-headers
	dev-util/yacc
	sys-devel/autoconf"
#	doc? ( app-text/openjade
#		dev-perl/SGMLSpm
#		app-text/docbook-sgml-dtd
#		app-text/docbook-sgml-utils )
RDEPEND="virtual/glibc"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/${P}-pfkey.patch include-glibc/net/pfkeyv2.h || die
	sed -i \
		-e "27s:-O2:${CFLAGS}:;68s:./configure:unset CFLAGS\;./configure:" \
		-e "20d;21d;22d;23d;24d" \
		-e "/^CC=/s:gcc:$(gcc-getCC):" \
		Makefile \
		|| die

	# not everybody wants ipv6 suids laying around on the filesystems

	use ipv6 || sed -i -e s:"IPV6_TARGETS=":"#IPV6_TARGETS=":g Makefile

	cd ${S}/racoon && gnuconfig_update
}

src_compile() {
	use static && append-ldflags -static

	if [ -e ${ROOT}/usr/include/linux/pfkeyv2.h ]; then
		sed -i -e '1s:/usr/src/linux/include:${ROOT}/usr/include:' libipsec/Makefile
		sed -i -e '1s:/usr/src/linux/include:${ROOT}/usr/include:' setkey/Makefile
		sed -i -e "1s:/usr/src/linux/include:${ROOT}/usr/include:;10s:-ll:-lfl ${LDFLAGS}:" setkey/Makefile
		sed -i -e "51s:ifdef:ifndef:;68d; 69d; 70d;" racoon/grabmyaddr.c
		sed -i -e '461i\LIBS="$LIBS -lfl -lresolv"' racoon/configure.in
		cd ${S}/libipsec && emake || die "libipsec failed"
		cd ${S}/setkey && emake || die "setkey failed"

		cd ${S}/racoon
		autoconf
		econf || die
		emake || die "make racoon failed"
	fi

	cd ${S}
	emake KERNEL_INCLUDE="${ROOT}/usr/include" || die "make main failed"

#	if use doc ; then
#		make html || die
#	fi
	make man || die "make man failed"
}

src_install() {
	if [ -e ${ROOT}/usr/include/linux/pfkeyv2.h ] ; then
		dodir /usr/sbin /usr/share/man/man{5,8}
		cd ${S}/racoon && einstall || die

		into /usr
		dobin ${S}/setkey/setkey
	fi

	cd ${S}
	into /
	dobin ping
	use ipv6 && dobin ping6
	dosbin arping
	into /usr
	dobin tracepath
	use ipv6 && dobin trace{path,route}6
	dosbin clockdiff rarpd rdisc ipg tftpd

	fperms 4711 /bin/ping /usr/bin/tracepath

	use ipv6 && fperms 4711 /bin/ping6 \
		/usr/bin/trace{path,route}6

	dodoc INSTALL RELNOTES

	use ipv6 || rm doc/*6.8
	doman doc/*.8

#	use doc && dohtml doc/*.html
}
