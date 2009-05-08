# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.88.ebuild,v 1.2 2009/05/08 18:31:12 tove Exp $

MODULE_AUTHOR=CHORNY
MODULE_A="${P}.zip"
inherit perl-module

DESCRIPTION="Perl module for Apache::Session"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Test-Deep
	virtual/perl-Digest-MD5
	virtual/perl-Storable
	dev-lang/perl"
DEPEND="${RDEPEND}
	app-arch/unzip"
