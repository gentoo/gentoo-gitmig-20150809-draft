# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-UUID/Data-UUID-0.11.ebuild,v 1.2 2006/01/09 21:15:01 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Perl extension for generating Globally/Universally Unique
Identifiers (GUIDs/UUIDs)."
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AG/AGOLOMSH/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=""
RDEPEND=""

