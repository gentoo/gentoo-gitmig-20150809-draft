# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-WWW-Mechanize/Test-WWW-Mechanize-1.340.0.ebuild,v 1.2 2012/03/25 15:33:41 armin76 Exp $

EAPI=4

MODULE_AUTHOR=PETDANCE
MODULE_VERSION=1.34
inherit perl-module

DESCRIPTION="Testing-specific WWW::Mechanize subclass"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="
	>=dev-perl/WWW-Mechanize-1.680.0
	dev-perl/Carp-Assert-More
	dev-perl/URI
	>=dev-perl/Test-LongString-0.150
"
DEPEND="${RDEPEND}"
#	test? (
#		>=dev-perl/HTTP-Server-Simple-0.35
#		dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage
#	)
#"

# SRC_TEST="do" # bug 328899
