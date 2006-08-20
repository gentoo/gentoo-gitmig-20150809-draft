# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ListDetector/Mail-ListDetector-0.34.ebuild,v 1.1 2006/08/20 03:14:46 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for detecting mailing list messages"
SRC_URI="mirror://cpan/authors/id/M/MS/MSTEVENS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

LICENSE="Artistic"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SLOT="0"
SRC_TEST="do"

DEPEND="dev-perl/URI
	dev-perl/Email-Valid
	dev-perl/Email-Abstract
	dev-lang/perl"
