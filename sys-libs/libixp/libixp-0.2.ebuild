# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libixp/libixp-0.2.ebuild,v 1.1 2006/12/28 07:20:16 omp Exp $

inherit toolchain-funcs

DESCRIPTION="Standalone client/server 9P library"
HOMEPAGE="http://libs.suckless.org/"
SRC_URI="http://libs.suckless.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^PREFIX/s/=.*/= \/usr/" \
		-e "/^CFLAGS/s/= -Os/+=/" \
		-e "/^LDFLAGS/s/=/+=/" \
		-e "/^AR/s/=.*/= $(tc-getAR) cr/" \
		-e "/^CC/s/=.*/= $(tc-getCC)/" \
		-e "/^RANLIB/s/=.*/= $(tc-getRANLIB)/" \
		config.mk || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
