# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/epm/epm-0.8.8.ebuild,v 1.11 2005/04/01 16:24:10 nigoro Exp $

DESCRIPTION="rpm workalike for Gentoo Linux"
HOMEPAGE="http://www.gentoo.org/~agriffis/epm/"
SRC_URI="http://www.gentoo.org/~agriffis/epm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha arm amd64 hppa ia64 mips ppc ppc-macos s390 sparc x86 ppc64"
IUSE=""

DEPEND=">=dev-lang/perl-5"

src_compile() {
	pod2man epm > epm.1 || die "pod2man failed"
}

src_install() {
	dobin epm || die
	doman epm.1
}
