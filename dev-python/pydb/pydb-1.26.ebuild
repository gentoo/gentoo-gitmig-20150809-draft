# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydb/pydb-1.26.ebuild,v 1.2 2009/04/18 21:27:42 patrick Exp $

DESCRIPTION="Extended python debugger"
HOMEPAGE="http://bashdb.sourceforge.net/pydb/"
SRC_URI="mirror://sourceforge/bashdb/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# emacs support could be made optional with some extra work
# sorry, I was too lazy
IUSE=""

DEPEND=">=dev-lang/python-2.4.0
	>=app-editors/emacs-22.0"

# This package uses not distutils but the usual
# ./configure; make; make install
# The default src_compile is OK

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die "dodoc failed"
}
