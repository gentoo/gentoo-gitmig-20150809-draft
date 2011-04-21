# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cloc/cloc-1.53.ebuild,v 1.1 2011/04/21 13:41:09 jer Exp $

DESCRIPTION="Count Lines of Code"
HOMEPAGE="http://cloc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6"

src_unpack() { :; }

src_install() {
	newbin "${DISTDIR}"/${P}.pl ${PN} || die
}
