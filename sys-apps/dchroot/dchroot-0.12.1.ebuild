# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dchroot/dchroot-0.12.1.ebuild,v 1.2 2009/11/18 16:58:35 vostorga Exp $

inherit toolchain-funcs

DESCRIPTION="Utility for managing chroots for non-root users"
HOMEPAGE="http://packages.debian.org/unstable/admin/dchroot"
SRC_URI="mirror://debian/pool/main/d/dchroot/dchroot_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/help2man"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^all:/s:$: docs:' \
		-e '/^CFLAGS/s:-O2:@CFLAGS@:' \
		-e '/@CFLAGS@/ s:@CFLAGS@:@CFLAGS@ @LDFLAGS@:' \
		Makefile.in || die "sed failed"
}

src_compile() {
	econf
	emake CC="$(tc-getCC)" || die
}

src_install() {
	einstall || die
	dodoc README TODO
}
