# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/halibut/halibut-0.9.ebuild,v 1.1 2004/09/03 21:52:41 usata Exp $

inherit flag-o-matic

DESCRIPTION="Halibut: yet another free document preparation system"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/halibut/"
SRC_URI="http://www.chiark.greenend.org.uk/~sgtatham/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	replace-flags -O[3-9] -O2

	emake \
		BUILDDIR="${S}/build" \
		VERSION="${PV}" \
		|| die "make failed"

	emake -C doc || die "make in doc failed"
}

src_install() {
	dobin build/halibut
	doman doc/halibut.1
	dodoc doc/halibut.txt
	dohtml doc/*.html
}
