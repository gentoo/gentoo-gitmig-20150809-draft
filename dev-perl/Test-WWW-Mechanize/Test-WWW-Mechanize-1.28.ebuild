# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-WWW-Mechanize/Test-WWW-Mechanize-1.28.ebuild,v 1.3 2010/06/21 20:24:40 armin76 Exp $

MODULE_AUTHOR=PETDANCE
inherit perl-module

DESCRIPTION="Testing-specific WWW::Mechanize subclass"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=dev-perl/WWW-Mechanize-1.24
	dev-perl/Carp-Assert-More
	dev-perl/URI
	>=dev-perl/Test-LongString-0.12
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( >=dev-perl/HTTP-Server-Simple-0.35
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
