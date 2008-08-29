# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mg/mg-20080610.ebuild,v 1.2 2008/08/29 22:14:17 maekke Exp $

DESCRIPTION="Micro GNU/emacs, a port from the BSDs"
HOMEPAGE="http://www.xs4all.nl/~hanb/software/mg/"
SRC_URI="http://www.xs4all.nl/~hanb/software/mg/${P}.tar.gz"

LICENSE="public-domain BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_compile() {
	# econf won't work, as this script does not accept any parameters
	./configure || die "configure failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install()  {
	einstall || die "einstall failed"
	dodoc README tutorial || die "dodoc failed"
}
