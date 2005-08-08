# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event-RPC/Event-RPC-0.84.ebuild,v 1.1 2005/08/08 10:57:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Event based transparent Client/Server RPC framework"
SRC_URI="mirror://cpan/modules/by-module/Event/${P}.tar.gz"
HOMEPAGE="http://www.exit1.org/${PN}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
IUSE=""
SRC_TEST="do"
