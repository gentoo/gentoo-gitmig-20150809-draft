# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/perl-cleaner/perl-cleaner-1.04.3.ebuild,v 1.10 2006/09/03 05:45:00 vapier Exp $

DESCRIPTION="User land tool for cleaning up old perl installs"
HOMEPAGE="http://dev.gentoo.org/~mcummings/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND="dev-lang/perl"

src_install() {
	dobin bin/perl-cleaner || die
	doman man/perl-cleaner.1
}
