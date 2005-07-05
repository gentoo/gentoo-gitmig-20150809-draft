# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-cpan/g-cpan-0.13.02.ebuild,v 1.2 2005/07/05 10:09:35 mcummings Exp $

DESCRIPTION="g-cpan: generate and install CPAN modules using portage"
HOMEPAGE="http://dev.gentoo.org/~mcummings/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

pkg_setup() {
	if hasq collision-protect $FEATURES; then
		ewarn "This ebuild will fail with collision-protect in place."
		ewarn "This ebuild is replacing a package that was previously"
		ewarn "bundled with portage directly. Please disable "
		ewarn "collision-protect for the installation of this package."
		die
	fi
}
src_unpack() {
	unpack ${A}
	cd ${S}
}

src_install() {
	dodir /usr/bin
	cp ${S}/bin/g-cpan.pl ${D}/usr/bin/
	dodir /usr/share/man/man1
	doman ${S}/man/g-cpan.pl.1
	dodoc Changes
	dosym /usr/bin/g-cpan.pl /usr/bin/g-cpan
	dosym /usr/share/man/man1/g-cpan.pl.1.gz /usr/share/man/man1/g-cpan.1.gz
}
