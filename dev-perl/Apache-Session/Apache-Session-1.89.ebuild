# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.89.ebuild,v 1.1 2010/09/30 18:57:50 robbat2 Exp $

MODULE_AUTHOR=CHORNY
inherit perl-module

DESCRIPTION="Perl module for Apache::Session"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Test-Deep
	virtual/perl-Digest-MD5
	virtual/perl-Storable
	dev-lang/perl"
DEPEND="${RDEPEND}
	app-arch/unzip"
