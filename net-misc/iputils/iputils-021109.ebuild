# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iputils/iputils-021109.ebuild,v 1.11 2004/04/07 05:37:32 vapier Exp $

DESCRIPTION="Network monitoring tools including ping and ping6"
HOMEPAGE="ftp://ftp.inr.ac.ru/ip-routing"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/${PN}-ss${PV}-try.tar.bz2
	http://ftp.iasi.roedu.net/mirrors/ftp.inr.ac.ru/ip-routing/${PN}-ss${PV}-try.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ppc ~hppa ~mips ~amd64 ~ia64 ~ppc64"
IUSE="static" #doc

DEPEND="virtual/glibc
	virtual/os-headers
	!ppc64? ( dev-util/yacc )"
#	not marked stable at all on ppc64?
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
	sed -e "27s:-O2:${CFLAGS}:;68s:./configure:unset CFLAGS\;./configure:" -i Makefile
	sed -e "20d;21d;22d;23d;24d" -i Makefile

}

src_compile() {

	use static && LDFLAGS="${LDFLAGS} -static"

	if [ -e ${ROOT}/usr/include/linux/pfkeyv2.h ]; then
		sed -e '1s:/usr/src/linux/include:/usr/include:' -i libipsec/Makefile
		sed -e '1s:/usr/src/linux/include:/usr/include:' -i setkey/Makefile
		sed -e '1s:/usr/src/linux/include:/usr/include:;10s:-ll:-lfl:' -i setkey/Makefile
		sed -e "51s:ifdef:ifndef:;68d; 69d; 70d;" -i racoon/grabmyaddr.c
		sed -e '461i\LIBS="$LIBS -lfl -lresolv"' -i racoon/configure.in
		cd ${S}/libipsec && emake || die
		cd ${S}/setkey && emake || die

		cd ${S}/racoon
		autoconf; econf || die; emake || die
	fi

	cd ${S}
	emake KERNEL_INCLUDE="/usr/include" || die

#	if [ "`use doc`" ]; then
#		make html || die
#	fi
	make man || die

}

src_install() {

	if [ -e ${ROOT}/usr/include/linux/pfkeyv2.h ]; then
		mkdir -p ${D}/usr/sbin; mkdir -p ${D}/usr/share/man/man8
		mkdir -p ${D}/usr/share/man/man5;
		cd ${S}/racoon && einstall || die

		into /usr
		dobin ${S}/setkey/setkey
	fi

	cd ${S}
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
