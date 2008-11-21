# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openais/openais-0.80.3-r1.ebuild,v 1.1 2008/11/21 22:55:48 xmerlin Exp $

inherit eutils flag-o-matic toolchain-funcs

IUSE="debug"
DESCRIPTION="Open Application Interface Specification cluster framework"
HOMEPAGE="http://www.openais.org/"
#SRC_URI="ftp://ftp%40openais%2Eorg:downloads@openais.org/downloads/${P}/${P}.tar.gz"
SRC_URI="http://devresources.linux-foundation.org/dev/openais/downloads/${P}/${P}.tar.gz"
LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile-ARCH.patch || die
	epatch "${FILESDIR}"/${P}-Makefile-LIBDIR.patch || die
	epatch "${FILESDIR}"/${P}-Makefile.inc-FLAGS.patch || die

	epatch "${FILESDIR}"/${P}-Makefile.inc-VARS.patch || die
	epatch "${FILESDIR}"/${P}-Makefile-VARS.patch || die

	#epatch "${FILESDIR}"/${P}-r1514.patch || die
	epatch "${FILESDIR}"/${P}-r1661.patch || die

	#epatch "${FILESDIR}"/${P}-r1661-pacemaker-openais.conf.patch || die
	#epatch "${FILESDIR}"/${P}-r1661-pacemaker.patch || die
	#epatch "${FILESDIR}"/pacemaker.diff || die
}

pkg_setup() {
	enewgroup ais
	enewuser ais -1 -1 -1 ais
}

src_compile() {
	useq debug && append-flags -O0 -ggdb -Wall -DDEBUG
	emake -j1 LIBDIR="/usr/$(get_libdir)/openais" \
		CFLAGS="${CFLAGS}" CC="$(tc-getCC)"
}

src_install() {
	emake LIBDIR="/usr/$(get_libdir)/openais" \
		DESTDIR="${D}" install || die "make install failed"

	insinto /etc/ais
	doins "${FILESDIR}"/openais.conf

	# http://bugs.gentoo.org/show_bug.cgi?id=160847#c16
	dosym /usr/sbin/aisexec /sbin/aisexec

	dodir /etc/env.d
	echo LDPATH="/usr/$(get_libdir)/openais" > "${D}"/etc/env.d/03openais

	newinitd "${FILESDIR}"/ais.initd ais

	diropts -o ais -g ais -m 0750
	keepdir /var/log/ais

	exeinto /usr/libexec/openais
	doexe exec/openais-instantiate || die
	doexe test/{ckptbench,ckptbenchth,ckpt-rd,ckptstress,ckpt-wr,clc_cli_script} || die
	doexe test/{cpgbench,evsbench,evtbench} || die
	doexe test/{publish,subscription,testamf1,testckpt,testclm,testclm2,testcpg,testcpg2} || die
	doexe test/{testevs,testevt,testlck,testmsg,unlink} || die

	dosbin test/openais-cfgtool || die

	dodoc CHANGELOG QUICKSTART README.* SECURITY TODO conf/*
}
