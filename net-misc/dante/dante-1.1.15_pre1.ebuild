# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dante/dante-1.1.15_pre1.ebuild,v 1.1 2004/11/02 21:43:51 agriffis Exp $

inherit gcc fixheadtails eutils

MY_PV=${PV/_/-}

DESCRIPTION="A free socks4,5 and msproxy implementation"
HOMEPAGE="http://www.inet.no/dante/"
SRC_URI="ftp://ftp.inet.no/pub/socks/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~ia64 ~ppc64 ~s390 ~amd64"
IUSE="tcpd debug"

RDEPEND="virtual/libc
	 sys-libs/pam
	 tcpd? ( sys-apps/tcp-wrappers )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/dante-1.1.15_pre1-socksify.patch
	epatch ${FILESDIR}/dante-1.1.14-bindresvport.patch
	ht_fix_file `find ${S} -name 'configure'`
	sed -i \
		-e 's:/etc/socks\.conf:/etc/socks/socks.conf:' \
		-e 's:/etc/sockd\.conf:/etc/socks/sockd.conf:' \
		doc/{faq.ps,faq.tex,sockd.8,sockd.conf.5,socks.conf.5}
}

src_compile() {
	econf \
		`use_enable debug` \
		`use_enable tcpd libwrap` \
		--with-socks-conf=/etc/socks/socks.conf \
		--with-sockd-conf=/etc/socks/sockd.conf \
		${myconf} \
		|| die "bad ./configure"
	# the comments in the source say this is only useful for 2.0 kernels ...
	# well it may fix 2.0 but it breaks with 2.6 :)
	[ "${KV:0:3}" == "2.6" ] && sed -i 's:if HAVE_LINUX_ECCENTRICITIES:if 0:' include/common.h
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
	newexe ${FILESDIR}/dante-sockd-init-1.1.14-r2 dante-sockd
	insinto /etc/conf.d
	newins ${FILESDIR}/dante-sockd-conf-1.1.14-r2 dante-sockd

	# install documentation
	dodoc BUGS CREDITS NEWS README SUPPORT TODO VERSION
	docinto txt
	cd doc
	dodoc README* *.txt SOCKS4.*
	docinto example
	cd ../example
	dodoc *.conf
}
