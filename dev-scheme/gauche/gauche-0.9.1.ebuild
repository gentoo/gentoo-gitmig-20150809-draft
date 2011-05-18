# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche/gauche-0.9.1.ebuild,v 1.1 2011/05/18 14:11:11 hattya Exp $

EAPI="3"

inherit autotools eutils

IUSE="ipv6"

MY_P="${P/g/G}"

DESCRIPTION="A Unix system friendly Scheme Interpreter"
HOMEPAGE="http://practical-scheme.net/gauche/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="sys-libs/gdbm"
RDEPEND="${DEPEND}"

src_prepare() {

	epatch "${FILESDIR}"/${PN}-rpath.diff
	epatch "${FILESDIR}"/${PN}-gauche.m4.diff
	epatch "${FILESDIR}"/${PN}-ext-ldflags.diff
	epatch "${FILESDIR}"/${P}-*.diff
	epatch "${FILESDIR}"/${PN}-xz-info.diff
	eautoconf

}

src_configure() {

	econf \
		$(use_enable ipv6) \
		--enable-multibyte=utf8 \
		--with-slib="${EPREFIX}"/usr/share/slib

}

src_compile() {

	emake -j1 || die

}

src_test() {

	emake -j1 -s check || die

}

src_install() {

	emake DESTDIR="${D}" install-pkg install-doc || die
	dodoc AUTHORS ChangeLog HACKING README || die

}
