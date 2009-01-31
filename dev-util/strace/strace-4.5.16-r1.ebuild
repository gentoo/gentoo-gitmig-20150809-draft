# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.5.16-r1.ebuild,v 1.14 2009/01/31 08:19:42 vapier Exp $

inherit flag-o-matic autotools

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="http://sourceforge.net/projects/strace/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="static aio"

DEPEND="aio? ( dev-libs/libaio )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#epatch "${FILESDIR}"/${PN}-4.5.11-fbsd.patch

	epatch "${FILESDIR}"/${PN}-4.5.15-invalid-time.patch #186369
	epatch "${FILESDIR}"/strace-fix-arm-bad-syscall.patch
	epatch "${FILESDIR}"/${PN}-4.5.12-libaio.patch #103427
	epatch "${FILESDIR}"/${P}-mips-syscallent.patch
	epatch "${FILESDIR}"/${P}-sh-updates.patch
	epatch "${FILESDIR}"/${P}-sparc-updates.patch #162789
	epatch "${FILESDIR}"/${P}-sparc-times.patch #204457
	epatch "${FILESDIR}"/${P}-getdents-infinite-loop.patch
	epatch "${FILESDIR}"/${P}-sparc-{fix,socketipc}.patch #fedora, 229229

	eautoreconf
}

src_compile() {
	filter-lfs-flags

	use static && append-ldflags -static

	econf $(use_enable aio libaio) || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog CREDITS NEWS PORTING README* TODO
}
