# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV-Simple/Text-CSV-Simple-1.00.ebuild,v 1.1 2006/05/23 07:08:20 ian Exp $

inherit perl-module

DESCRIPTION="Text::CSV::Simple - Simpler parsing of CSV files"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
RDEPEND="dev-perl/Text-CSV_XS
		dev-perl/Class-Trigger
		dev-perl/File-Slurp"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
SRC_TEST="do"
