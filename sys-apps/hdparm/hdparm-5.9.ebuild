# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.9.ebuild,v 1.9 2005/06/30 03:42:52 kumba Exp $

inherit toolchain-funcs

DESCRIPTION="Utility to change hard drive performance parameters"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/hardware/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^CFLAGS/s:-O2:${CFLAGS}:" \
		-e "/^LDFLAGS/ s:-s:${LDFLAGS}:" \
		Makefile || die "sed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "compile error"
}

src_install() {
	into /
	dosbin hdparm contrib/idectl || die "dosbin"

	newinitd ${FILESDIR}/hdparm-init-7 hdparm
	newconfd ${FILESDIR}/hdparm-conf.d.3 hdparm

	doman hdparm.8
	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}
