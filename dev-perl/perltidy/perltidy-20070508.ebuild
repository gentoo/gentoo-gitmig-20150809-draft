# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20070508.ebuild,v 1.2 2007/06/25 17:08:19 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P/perltidy/Perl-Tidy}
DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"
SRC_URI="mirror://sourceforge/perltidy/${P/perltidy/Perl-Tidy}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

mydoc="examples/*"

mymake="/usr"

pkg_postinst() {
	elog "Example scripts can be found in /usr/share/doc/${P}"
}


DEPEND="dev-lang/perl"
