# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libsrs_alt/libsrs_alt-1.0_rc1-r1.ebuild,v 1.1 2005/07/15 17:20:50 peitolm Exp $

MY_PV=${PV%_rc*}
MY_RC=${PV#*_rc}
S=${WORKDIR}/${PN}-${MY_PV}rc${MY_RC}

DESCRIPTION="Sender Rewriting Scheme library"
HOMEPAGE="http://srs.mirtol.com/"
SRC_URI="http://srs.mirtol.com/libsrs_alt-${MY_PV}rc${MY_RC}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_compile() {
	# Since the primary intended consumers of this library are MTAs,
	# use non-standard separator characters (--with-base64compat).
	# This breaks "SRS Compliancy", which is a rough standard at
	# best.
	econf --with-base64compat || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc ${S}/MTAs/README.EXIM
}
