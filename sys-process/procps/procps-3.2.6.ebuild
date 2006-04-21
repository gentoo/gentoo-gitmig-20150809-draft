# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/procps/procps-3.2.6.ebuild,v 1.10 2006/04/21 22:23:32 vapier Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Standard informational utilities and process-handling tools"
HOMEPAGE="http://procps.sourceforge.net/"
SRC_URI="http://procps.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="n32"

RDEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/3.2.5-top-sort.patch
	epatch "${FILESDIR}"/procps-3.2.5-proc-mount.patch
	epatch "${FILESDIR}"/procps-3.2.3-noproc.patch
	epatch "${FILESDIR}"/procps-3.2.6-links.patch

	# Clean up the makefile
	#  - we do stripping ourselves
	#  - punt fugly gcc flags
	sed -i \
		-e '/install/s: --strip : :' \
		-e '/ALL_CFLAGS += $(call check_gcc,-fweb,)/d' \
		-e '/ALL_CFLAGS += $(call check_gcc,-Wstrict-aliasing=2,)/s,=2,,' \
		-e "/^lib64/s:=.*:=$(get_libdir):" \
		-e 's:-m64::g' \
		Makefile || die "sed Makefile"

	# mips 2.4.23 headers (and 2.6.x) don't allow PAGE_SIZE to be defined in
	# userspace anymore, so this patch instructs procps to get the
	# value from sysconf().
	epatch "${FILESDIR}"/${PN}-mips-define-pagesize.patch

	# n32 isn't completly reliable of an ABI on mips64 at the current
	# time.  Eventually, it will be, but for now, we need to make sure
	# procps doesn't try to force it on us.
	if ! use n32 ; then
		epatch "${FILESDIR}"/${P}-mips-n32_isnt_usable_on_mips64_yet.patch
	fi
}

src_compile() {
	replace-flags -O3 -O2
	emake \
		CC="$(tc-getCC)" \
		CPPFLAGS="${CPPFLAGS}" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "make failed"
}

src_install() {
	make install ldconfig="true" DESTDIR="${D}" || die "install failed"

	insinto /usr/include/proc
	doins proc/*.h || die "doins include"

	dodoc sysctl.conf BUGS NEWS TODO ps/HACKING
}

pkg_postinst() {
	einfo "NOTE: With NPTL \"ps\" and \"top\" no longer"
	einfo "show threads. You can use any of: -m m -L -T H"
	einfo "in ps or the H key in top to show them"
}
