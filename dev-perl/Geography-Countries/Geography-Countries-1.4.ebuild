# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geography-Countries/Geography-Countries-1.4.ebuild,v 1.7 2006/03/22 20:41:07 flameeyes Exp $

inherit perl-module

DESCRIPTION="2-letter, 3-letter, and numerical codes for countries."
SRC_URI="mirror://cpan/authors/id/A/AB/ABIGAIL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~abigail/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
