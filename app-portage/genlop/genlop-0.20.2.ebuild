# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/genlop/genlop-0.20.2.ebuild,v 1.3 2004/03/21 02:50:07 avenj Exp $

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="http://pollycoke.org/genlop.html"
SRC_URI="http://pollycoke.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc ~amd64"

RDEPEND=">=dev-lang/perl-5.8.0-r12
		>=dev-perl/Time-Duration-1.02"

src_install() {
	dobin genlop || die
	dodoc README Changelog genlop.bash-completion
	doman genlop.1
}
