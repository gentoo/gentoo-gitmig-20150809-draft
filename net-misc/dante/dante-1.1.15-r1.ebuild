# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dante/dante-1.1.15-r1.ebuild,v 1.2 2005/03/20 23:15:08 mrness Exp $

inherit gcc fixheadtails eutils

MY_PV=${PV/_/-}

DESCRIPTION="A free socks4,5 and msproxy implementation"
HOMEPAGE="http://www.inet.no/dante/"
SRC_URI="ftp://ftp.inet.no/pub/socks/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="tcpd debug selinux pam"

RDEPEND="virtual/libc
	pam? ( sys-libs/pam )
	tcpd? ( sys-apps/tcp-wrappers )
	selinux? ( sec-policy/selinux-dante )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/automake-1.9"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}_pre1-socksify.patch
	epatch ${FILESDIR}/${P}-bindresvport.patch
	epatch ${FILESDIR}/${P}-optionalpam.patch
	epatch ${FILESDIR}/${P}-getipnodebyname.patch

	ht_fix_file configure configure.ac
	sed -i \
		-e 's:/etc/socks\.conf:/etc/socks/socks.conf:' \
		-e 's:/etc/sockd\.conf:/etc/socks/sockd.conf:' \
		doc/{faq.ps,faq.tex,sockd.8,sockd.conf.5,socks.conf.5}
}

src_compile() {
	libtoolize --copy --force
	econf \
		`use_enable debug` \
		`use_enable tcpd libwrap` \
		`use_with pam` \
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
	newexe ${FILESDIR}/dante-sockd-init dante-sockd
	insinto /etc/conf.d
	newins ${FILESDIR}/dante-sockd-conf dante-sockd

	# install documentation
	dodoc BUGS CREDITS NEWS README SUPPORT TODO VERSION
	docinto txt
	cd doc
	dodoc README* *.txt SOCKS4.*
	docinto example
	cd ../example
	dodoc *.conf
}
