# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/genlop/genlop-0.30.2.ebuild,v 1.12 2005/04/07 23:21:18 genone Exp $

inherit bash-completion

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="http://pollycoke.org/genlop.html"
SRC_URI="http://pollycoke.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.0-r12
	 >=dev-perl/DateManip-5.40"

src_install() {
	dobin genlop || die
	dodoc README Changelog
	doman genlop.1
	dobashcompletion genlop.bash-completion genlop
}
