# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS-Feed/XML-RSS-Feed-2.1.ebuild,v 1.8 2006/10/20 13:16:30 mcummings Exp $

inherit perl-module

DESCRIPTION="Persistant XML RSS Encapsulation"
HOMEPAGE="http://search.cpan.org/~jbisbee/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JB/JBISBEE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/HTML-Parser
	dev-perl/XML-RSS
		dev-perl/Clone
		virtual/perl-Time-HiRes
		dev-perl/URI
		virtual/perl-Digest-MD5
	dev-lang/perl"

