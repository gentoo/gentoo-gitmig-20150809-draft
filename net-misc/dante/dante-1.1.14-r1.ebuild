# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dante/dante-1.1.14-r1.ebuild,v 1.1 2003/12/08 22:00:43 agriffis Exp $

inherit gcc

DESCRIPTION="A free socks4,5 and msproxy implemetation"
HOMEPAGE="http://www.inet.no/dante/"
SRC_URI="ftp://ftp.inet.no/pub/socks/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ia64"
IUSE="tcpd debug"

DEPEND="virtual/glibc
	sys-libs/pam
	tcpd? ( sys-apps/tcp-wrappers )
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S}     || die "cd failed"
	epatch ${FILESDIR}/dante-1.1.14-socksify.patch || die "epatch failed"
	epatch ${FILESDIR}/dante-1.1.14-bindresvport.patch || die "epatch failed"
}

src_compile() {
	econf \
		`use_enable debug` \
		`use_enable tcpd libwrap` \
		--with-socks-conf=/etc/socks/socks.conf \
		--with-sockd-conf=/etc/socks/sockd.conf \
		${myconf} \
		|| die "bad ./configure"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die

	# bor: comment libdl.so out it seems to work just fine without it
	sed -i -e 's:libdl\.so::' ${D}/usr/bin/socksify || die 'sed failed'

	# no configuration file by default
	dodir /etc/socks

	# our init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/dante-sockd-init dante-sockd

	# install documentation
	dodoc BUGS CREDITS LICENSE NEWS README SUPPORT TODO VERSION
	docinto txt
	cd doc
	dodoc README* *.txt SOCKS4.*
	docinto example
	cd ../example
	dodoc *.conf
}
