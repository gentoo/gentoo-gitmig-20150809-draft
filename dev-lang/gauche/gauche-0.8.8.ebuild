# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gauche/gauche-0.8.8.ebuild,v 1.1 2006/12/01 11:37:47 hattya Exp $

inherit autotools eutils flag-o-matic

IUSE="ipv6"

MY_P=${P/g/G}

DESCRIPTION="A Unix system friendly Scheme Interpreter"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
SLOT="0"
S=${WORKDIR}/${MY_P}

DEPEND=">=sys-libs/gdbm-1.8.0"

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-dbm.ac.diff
	epatch "${FILESDIR}"/${PN}-gauche.m4.diff
	epatch "${FILESDIR}"/${PN}-runpath.diff
	epatch "${FILESDIR}"/${P}-report-error.diff

	eautoconf

}

src_compile() {

	local myconf="--enable-threads=pthreads --enable-multibyte=utf8"

	strip-flags

	econf \
		`use_enable ipv6` \
		${myconf} \
		|| die
	emake || die

}

src_test() {

	emake -j1 -s check || die

}

src_install() {

	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog HACKING README

}

pkg_postinst() {

	echo
	ewarn "As of version 0.8.6, Gauche switched the default character"
	ewarn "encoding from euc-jp to utf-8."
	echo

}
