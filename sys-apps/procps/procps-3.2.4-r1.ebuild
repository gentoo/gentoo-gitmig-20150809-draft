# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-3.2.4-r1.ebuild,v 1.1 2005/01/13 01:21:47 vapier Exp $

inherit flag-o-matic eutils toolchain-funcs

DESCRIPTION="Standard informational utilities and process-handling tools"
HOMEPAGE="http://procps.sourceforge.net/"
SRC_URI="http://${PN}.sf.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Upstream patch to support newer linux #77301
	epatch "${FILESDIR}"/${PV}-linux26-slab.patch

	# Clean up the makefile
	# firstly we want to control stripping
	# and secondly these gcc flags have changed
	sed -i \
		-e '/install/s: --strip : :' \
		-e '/ALL_CFLAGS += $(call check_gcc,-fweb,)/d' \
		-e '/ALL_CFLAGS += $(call check_gcc,-Wstrict-aliasing=2,)/s,=2,,' \
		Makefile || die "sed Makefile"
	use ppc && sed -i -e 's:-m64::g' Makefile

	# mips 2.4.23 headers (and 2.6.x) don't allow PAGE_SIZE to be defined in
	# userspace anymore, so this patch instructs procps to get the
	# value from sysconf().
	use mips && epatch ${FILESDIR}/${PN}-mips-define-pagesize.patch
}

src_compile() {
	replace-flags -O3 -O2
	emake \
		lib64="$(get_libdir)" \
		CC="$(tc-getCC)" \
		CPPFLAGS="${CPPFLAGS}" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"

	insinto /usr/include/proc
	doins proc/*.h || die "doins include"

	dodoc sysctl.conf BUGS NEWS TODO ps/HACKING
}

pkg_postinst() {
	einfo "NOTE: With NPTL \"ps\" and \"top\" no longer"
	einfo "show threads. You can use any of: -m m -L -T H"
	einfo "in ps or the H key in top to show them"
}
