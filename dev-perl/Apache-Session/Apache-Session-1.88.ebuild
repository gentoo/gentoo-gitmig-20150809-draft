# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.88.ebuild,v 1.1 2008/12/23 08:30:52 robbat2 Exp $

MODULE_AUTHOR=CHORNY
MODULE_A="${P}.zip"
inherit perl-module

DESCRIPTION="Perl module for Apache::Session"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/Test-Deep
	virtual/perl-Digest-MD5
	virtual/perl-Storable
	dev-lang/perl"
