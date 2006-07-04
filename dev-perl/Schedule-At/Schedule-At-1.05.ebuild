# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Schedule-At/Schedule-At-1.05.ebuild,v 1.4 2006/07/04 19:56:46 ian Exp $

inherit perl-module

DESCRIPTION="OS independent interface to the Unix 'at' command"
SRC_URI="mirror://cpan/authors/id/J/JO/JOSERODR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Schedule-At/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="sys-process/at"
RDEPEND="${DEPEND}"