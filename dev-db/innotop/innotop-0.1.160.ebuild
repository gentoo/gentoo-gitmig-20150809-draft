# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/innotop/innotop-0.1.160.ebuild,v 1.1 2006/11/15 14:09:09 vivo Exp $

inherit perl-app

DESCRIPTION="innotop - A text-mode MySQL and InnoDB monitor like mytop, but with many more features"
HOMEPAGE="http://www.xaprb.com/innotop/"
SRC_URI="http://www.xaprb.com/innotop/src/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-perl/DBD-mysql
	dev-perl/TermReadKey
	dev-perl/Term-ANSIColor
	virtual/perl-Time-HiRes"

src_install() {
	perl-module_src_install
}
