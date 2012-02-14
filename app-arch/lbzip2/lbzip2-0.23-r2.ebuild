# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lbzip2/lbzip2-0.23-r2.ebuild,v 1.10 2012/02/14 21:25:31 jer Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Parallel bzip2 utility"
HOMEPAGE="http://lacos.hu/"
SRC_URI="http://lacos.web.elte.hu/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="symlink test"

RDEPEND="app-arch/bzip2"
DEPEND="${REDEPEND}
	test? (
		app-shells/bash
		sys-devel/bc
		|| ( sys-process/time sys-freebsd/freebsd-ubin )
	)"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/0.23-s_isreg.patch
	epatch "${FILESDIR}"/0.23-Makefile.patch
	epatch "${FILESDIR}"/0.23-test.sh.patch
}

src_compile() {
	append-lfs-flags
	emake CC=$(tc-getCC) || die "emake failed"
}

src_test() {
	if [ -t 0 ] || return; then
		rm -rf "${T}/scratch" "${T}/results" "${T}/rnd"
		hexdump -n 10485760 /dev/urandom > "${T}/rnd"
		emake -j1 SHELL="${EPREFIX}/bin/bash --posix" PATH="${S}:${PATH}" TESTFILE="${T}/rnd" check \
			|| die "make check failed"
	else
		ewarn "make check must be run attached to a terminal"
	fi
}

src_install() {
	dobin ${PN} || die "Installation of ${PN} failed"
	dodoc ChangeLog README || die "no docs"
	doman ${PN}.1 || die "no man"
	insinto /usr/share/${PN}
	doins corr-perf.sh malloc_trace.pl || die

	if use symlink; then
		dosym ${PN} /usr/bin/bzip2 || die
	fi
}
