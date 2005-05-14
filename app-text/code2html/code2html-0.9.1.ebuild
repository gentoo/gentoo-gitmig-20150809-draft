# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/code2html/code2html-0.9.1.ebuild,v 1.9 2005/05/14 01:07:45 wormo Exp $

DESCRIPTION="Converts source files to colored HTML output."
HOMEPAGE="http://www.palfrader.org/code2html/"
SRC_URI="http://www.palfrader.org/code2html/all/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"

KEYWORDS="x86 amd64 ppc64 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5"

src_install () {
	into /usr
	dobin code2html
	dodoc ChangeLog CREDITS LICENSE README
	doman code2html.1
}
