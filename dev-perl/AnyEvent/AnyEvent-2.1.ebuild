# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent/AnyEvent-2.1.ebuild,v 1.5 2007/03/05 11:02:35 ticho Exp $

inherit perl-module

DESCRIPTION="provide framework for multiple event loops"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mlehmann/AnyEvent-1.02/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Event
	dev-lang/perl"
