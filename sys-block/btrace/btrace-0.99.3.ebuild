# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/btrace/btrace-0.99.3.ebuild,v 1.2 2008/09/03 21:01:12 opfer Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="btrace can show detailed info about what is happening on a block device io queue."
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/axboe/blktrace/"
MY_PN="blktrace"
MY_P="${MY_PN}-${PV}"
SRC_URI="http://brick.kernel.dk/snaps/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
RDEPEND="virtual/libc"
# This is a Linux specific app!
DEPEND="${RDEPEND}
		|| ( sys-kernel/linux-headers sys-kernel/mips-headers )
		doc? ( virtual/latex-base )
		dev-libs/libaio"
S="${WORKDIR}/${MY_PN}"

src_compile() {
	append-flags -DLVM_REMAP_WORKAROUND -W -I"${S}"
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
	if use doc; then
		emake docs || die "emake docs failed"
	fi
}

src_install() {
	emake install DESTDIR="${D}" prefix="/usr" mandir="/usr/share/man" || die "emake install failed"
	dodoc README
	use doc && dodoc doc/blktrace.pdf btt/doc/btt.pdf
}
