# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libixp/libixp-0.2-r1.ebuild,v 1.6 2007/11/19 03:56:00 omp Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Standalone client/server 9P library"
HOMEPAGE="http://libs.suckless.org/"
SRC_URI="http://libs.suckless.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND="!>sys-libs/libixp-0.2"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/libixp-0.2-shared-object.patch"

	sed -i \
		-e "/^PREFIX/s|=.*|= /usr|" \
		-e "/^CFLAGS/s|= -Os|+=|" \
		-e "/^LDFLAGS/s|=|+=|" \
		-e "/^AR/s|=.*|= $(tc-getAR) cr|" \
		-e "/^CC/s|=.*|= $(tc-getCC)|" \
		-e "/^RANLIB/s|=.*|= $(tc-getRANLIB)|" \
		config.mk || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
