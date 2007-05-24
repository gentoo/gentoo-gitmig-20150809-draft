# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/genlop/genlop-0.30.7.ebuild,v 1.5 2007/05/24 21:26:01 kloeri Exp $

inherit bash-completion

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="http://www.gentoo.org/proj/en/perl"
SRC_URI="mirror://gentoo//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ia64 mips ~ppc ~ppc64 ~s390 ~sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0-r12
	 >=dev-perl/DateManip-5.40
	 dev-perl/libwww-perl"
RDEPEND="${DEPEND}"

src_install() {
	dobin genlop || die
	dodoc README Changelog
	doman genlop.1
	dobashcompletion genlop.bash-completion genlop
}
