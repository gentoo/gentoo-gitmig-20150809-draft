# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/when/when-1.0.16.ebuild,v 1.1 2005/01/09 02:20:43 ka0ttic Exp $

DESCRIPTION="Extremely simple personal calendar program aimed at the Unix geek who wants something minimalistic"
HOMEPAGE="http://www.lightandmatter.com/when/when.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-lang/perl-5.005"

src_compile() {
	emake ${PN}.html || die "emake failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman ${PN}.1 || die "doman failed"
	dodoc README
	dohtml ${PN}.html || die "dohtml failed"
}
