# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-cpan/g-cpan-0.12.ebuild,v 1.1 2005/04/30 22:19:39 mcummings Exp $

DESCRIPTION="g-cpan: generate and install CPAN modules using portage"
HOMEPAGE="http://dev.gentoo.org/~mcummings/"
SRC_URI="mirorr://gentoo/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE=""

DEPEND="dev-lang/perl
		dev-perl/Digest-MD5"

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
	cp ${S}/man/g-cpan.pl.1 ${D}/usr/share/man/man1/
	dodoc Changes
	dosym /usr/bin/g-cpan.pl /usr/bin/g-cpan
}
