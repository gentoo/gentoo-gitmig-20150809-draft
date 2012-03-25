# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/atool/atool-0.37.0.ebuild,v 1.5 2012/03/25 17:11:25 armin76 Exp $

DESCRIPTION="a script for managing file archives of various types"
HOMEPAGE="http://www.nongnu.org/atool/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/perl
	!app-text/adiff"

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
	dodoc AUTHORS ChangeLog NEWS README TODO
}
