# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-i18n/aspell-nl/aspell-nl-0.0_pre10.ebuild,v 1.1 2002/08/15 00:31:26 seemant Exp $

MY_P=${P/_pre/-0.}
S=${WORKDIR}/${MY_P}
DESCRIPTION="English dictionary for aspell"
HOMEPAGE="http://www.gnu.org/projects/aspell/index.html"
SRC_URI="http://savannah.gnu.org/download/aspell/dicts/${MY_P}.tar.bz2"

DEPEND="app-text/aspell"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		install || die

	dodoc Copyright README info
}
