# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event-RPC/Event-RPC-1.00.ebuild,v 1.1 2008/09/20 11:10:08 tove Exp $

MODULE_AUTHOR=JRED
inherit perl-module

DESCRIPTION="Event based transparent Client/Server RPC framework"
HOMEPAGE="http://www.exit1.org/Event-RPC/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="|| ( dev-perl/Event dev-perl/glib-perl )
	dev-perl/IO-Socket-SSL
	dev-perl/Net-SSLeay
	virtual/perl-Storable
	dev-lang/perl"
