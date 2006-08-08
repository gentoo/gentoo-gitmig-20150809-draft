# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event-ExecFlow/Event-ExecFlow-0.61.ebuild,v 1.9 2006/08/08 03:44:32 tsunam Exp $

inherit perl-module

DESCRIPTION="High level API for event-based execution flow control"
SRC_URI="mirror://cpan/modules/by-module/Event/${P}.tar.gz"
HOMEPAGE="http://www.exit1.org/${PN}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/AnyEvent
	dev-perl/libintl-perl
	dev-lang/perl"
RDEPEND="${DEPEND}"

