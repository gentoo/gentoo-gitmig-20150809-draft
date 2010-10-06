# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche/gauche-0.9-r1.ebuild,v 1.1 2010/10/06 19:32:42 chiiph Exp $

EAPI="3"

inherit autotools eutils flag-o-matic

IUSE="ipv6"

MY_P="${P/g/G}"

DESCRIPTION="A Unix system friendly Scheme Interpreter"
HOMEPAGE="http://practical-scheme.net/gauche/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="sys-libs/gdbm"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gauche.m4.diff
	epatch "${FILESDIR}"/${PN}-runpath.diff
	eautoconf
}

src_configure() {
#    strip-flags
	econf \
		`use_enable ipv6` \
		--enable-multibyte=utf8 \
		--with-slib=/usr/share/slib
}

src_compile() {
	emake -j1 XLDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_test() {
	emake -j1 -s check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install-pkg install-doc || die "emake install failed"
	dodoc AUTHORS ChangeLog HACKING README || die "dodoc failed"
}
