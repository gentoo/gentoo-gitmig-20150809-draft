# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.3.0.ebuild,v 1.1 2007/10/14 07:55:57 genstef Exp $

inherit libtool eutils autotools

DESCRIPTION="An open-source implementation of Service Location Protocol"
HOMEPAGE="http://www.openslp.org/"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""
RESTRICT="test"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/openslp-compile_fix.patch
	epatch "${FILESDIR}"/openslp-no_install_doc.patch
	epatch "${FILESDIR}"/openslp-opt.patch

	eautoreconf
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS FAQ ChangeLog NEWS README* THANKS
	dohtml -r doc/*
	newinitd "${FILESDIR}"/slpd-init slpd
}
