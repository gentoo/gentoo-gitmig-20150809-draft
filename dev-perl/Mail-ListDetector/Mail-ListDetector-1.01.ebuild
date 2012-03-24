# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ListDetector/Mail-ListDetector-1.01.ebuild,v 1.6 2012/03/24 20:07:05 armin76 Exp $

inherit perl-module

DESCRIPTION="Perl extension for detecting mailing list messages"
SRC_URI="mirror://cpan/authors/id/M/MS/MSTEVENS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

LICENSE="Artistic"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

SLOT="0"
SRC_TEST="do"

DEPEND="dev-perl/URI
	dev-perl/Email-Valid
	dev-perl/Email-Abstract
	dev-lang/perl"
