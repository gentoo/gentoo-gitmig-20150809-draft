# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/genlop/genlop-0.30.1.ebuild,v 1.1 2004/03/28 01:55:18 genone Exp $

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="http://pollycoke.org/genlop.html"
SRC_URI="http://pollycoke.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

RDEPEND=">=dev-lang/perl-5.8.0-r12
	 >=dev-perl/Time-Duration-1.02
	 >=dev-perl/DateManip-5.40"

src_install() {
	dobin genlop || die
	dodoc README Changelog
	doman genlop.1
	dodir /usr/share/bash-completion
	insinto /usr/share/bash-completion
	newins genlop.bash-completion genlop
}
