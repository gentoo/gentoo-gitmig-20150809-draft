# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lbzip2/lbzip2-0.23-r1.ebuild,v 1.9 2011/07/10 17:34:39 armin76 Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Parallel bzip2 utility"
HOMEPAGE="http://lacos.hu/"
SRC_URI="http://lacos.web.elte.hu/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="symlink test"

RDEPEND="app-arch/bzip2"
DEPEND="${REDEPEND}
	test? (
		app-shells/dash
		sys-devel/bc
		sys-process/time
	)"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-s_isreg.patch
	epatch "${FILESDIR}"/0.22-Makefile.patch
}

src_compile() {
	append-lfs-flags
	emake CC=$(tc-getCC) || die "emake failed"
}

src_test() {
	if [ -t 0 ] || return; then
		rm -rf "${T}/scratch" "${T}/results" "${T}/rnd"
		hexdump -n 10485760 /dev/urandom > "${T}/rnd"
		emake -j1 SHELL="${EPREFIX}"/bin/dash PATH="${S}:${PATH}" TESTFILE="${T}/rnd" check \
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
