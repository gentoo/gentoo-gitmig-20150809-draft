# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.5.14.ebuild,v 1.13 2006/12/02 20:35:58 vapier Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit flag-o-matic autotools

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="http://sourceforge.net/projects/strace/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ~s390 sh sparc x86"
IUSE="static aio"

DEPEND="aio? ( dev-libs/libaio )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	[[ ${CHOST} == *-freebsd* ]] && epatch "${FILESDIR}"/${PN}-4.5.12-fbsd.patch

	epatch "${FILESDIR}"/${P}-PT_GETSIGINFO.patch #149945

	# Fix SuperH support
	epatch "${FILESDIR}"/strace-dont-use-REG_SYSCALL-for-sh.patch
	epatch "${FILESDIR}"/${PN}-4.5.12-superh-update.patch

	# Fix building on older ARM machines
	epatch "${FILESDIR}"/strace-undef-syscall.patch
	epatch "${FILESDIR}"/strace-fix-arm-bad-syscall.patch

	# Fix libaio support #103427
	epatch "${FILESDIR}"/${PN}-4.5.12-libaio.patch

	# Remove some obsolete ia64-related hacks from the strace source
	# (08 Feb 2005 agriffis)
	epatch "${FILESDIR}"/strace-4.5.8-ia64.patch

	epatch "${FILESDIR}"/${P}-CTL_PROC.patch #150907

	eautoreconf
}

src_compile() {
	# Compile fails with -O3 on sparc but works on x86
	use sparc && replace-flags -O3 -O2
	filter-lfs-flags

	use static && append-ldflags -static

	econf $(use_enable aio libaio) || die
	emake || die
}

src_install() {
	# Can't use make install because it is stupid and
	# doesn't make leading directories before trying to
	# install. Thus, one would have to make /usr/bin
	# and /usr/man/man1 (at least).
	# So, we do it by hand.
	doman strace.1
	dobin strace strace-graph || die
	dodoc ChangeLog CREDITS NEWS PORTING README* TODO
}
