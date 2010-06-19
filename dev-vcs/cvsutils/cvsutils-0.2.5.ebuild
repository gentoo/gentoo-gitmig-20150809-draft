# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvsutils/cvsutils-0.2.5.ebuild,v 1.1 2010/06/19 00:32:46 abcd Exp $

DESCRIPTION="A small bundle of utilities to work with CVS repositories"
HOMEPAGE="http://www.red-bean.com/cvsutils/"
SRC_URI="http://www.red-bean.com/cvsutils/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README THANKS NEWS
}
