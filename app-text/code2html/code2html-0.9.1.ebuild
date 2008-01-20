# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/code2html/code2html-0.9.1.ebuild,v 1.13 2008/01/20 16:45:16 grobian Exp $

DESCRIPTION="Converts source files to colored HTML output."
HOMEPAGE="http://www.palfrader.org/code2html/"
SRC_URI="http://www.palfrader.org/code2html/all/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"

KEYWORDS="amd64 ~hppa ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5"

src_install () {
	into /usr
	dobin code2html
	dodoc ChangeLog CREDITS LICENSE README
	doman code2html.1
}
