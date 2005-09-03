# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/atool/atool-0.31.0.ebuild,v 1.1 2005/09/03 08:19:12 dragonheart Exp $

DESCRIPTION="script for managing file archives of various types (atr,tar+gzip,zip,etc)"
HOMEPAGE="http://www.nongnu.org/atool/"
SRC_URI="http://savannah.nongnu.org/download/atool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	make DESTDIR=${D} install ||die 'install failed'
	dodoc ChangeLog TODO README NEWS
}
