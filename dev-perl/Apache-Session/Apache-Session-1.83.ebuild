# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.83.ebuild,v 1.6 2008/09/30 07:56:04 tove Exp $

MODULE_AUTHOR=CHORNY
inherit perl-module

DESCRIPTION="Perl module for Apache::Session"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-perl/Test-Deep
	virtual/perl-Digest-MD5
	virtual/perl-Storable
	dev-lang/perl"
