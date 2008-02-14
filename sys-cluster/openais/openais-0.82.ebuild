# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openais/openais-0.82.ebuild,v 1.2 2008/02/14 19:04:19 wschlich Exp $

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
	epatch "${FILESDIR}"/Makefile-ARCH.patch
	epatch "${FILESDIR}"/Makefile-LIBDIR.patch
	epatch "${FILESDIR}"/Makefile-install.patch
	epatch "${FILESDIR}"/Makefile.inc-FLAGS.patch
}

pkg_setup() {
	enewgroup ais
	enewuser ais -1 -1 -1 ais
}

src_compile() {
	useq debug && append-flags -O0 -ggdb -Wall -DDEBUG
	emake LIBDIR="/usr/$(get_libdir)/openais" \
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
	doexe exec/openais-instantiate
	doexe test/{ckptbench,ckptbenchth,ckpt-rd,ckptstress,ckpt-wr,clc_cli_script}
	doexe test/{cpgbench,evsbench,evtbench,logsys_s,logsys_t1,logsys_t2}
	doexe test/{publish,subscription,testamf1,testckpt,testclm,testclm2,testcpg,testcpg2}
	doexe test/{testevs,testevt,testlck,testmsg,unlink}

	dosbin test/openais-cfgtool

	dodoc CHANGELOG QUICKSTART README.* SECURITY TODO conf/*
}
