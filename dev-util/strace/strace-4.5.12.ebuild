# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.5.12.ebuild,v 1.2 2005/08/18 00:24:41 vapier Exp $

inherit flag-o-matic

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="http://sourceforge.net/projects/strace/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~s390 ~sparc ~x86"
IUSE="static"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	if [[ ${CTARGET:-${CHOST}} == *-freebsd* ]] ; then
		epatch ${FILESDIR}/${P}-fbsd.patch
	fi
	# Fix support for newer glibc snapshots #102080
	epatch "${FILESDIR}"/${P}-quota.patch
	aclocal && autoheader && autoconf && automake || die "autotools failed"

	# Fix SuperH support
	epatch "${FILESDIR}"/strace-dont-use-REG_SYSCALL-for-sh.patch
	epatch "${FILESDIR}"/strace-superh-update.patch

	# Fix building on older ARM machines
	epatch "${FILESDIR}"/strace-undef-syscall.patch

	# Remove some obsolete ia64-related hacks from the strace source
	# (08 Feb 2005 agriffis)
	epatch ${FILESDIR}/strace-4.5.8-ia64.patch

	# This is ugly but linux26-headers-2.6.8.1-r2 (and other versions) has some
	# issues with definition of s64 and friends.  This seems to solve
	# compilation in this case (08 Feb 2005 agriffis)
	use ia64 && append-flags -D_ASM_IA64_PAL_H

	# Compile fails with -O3 on sparc but works on x86
	use sparc && replace-flags -O[3-9] -O2
	filter-lfs-flags

	use static && append-ldflags -static
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
