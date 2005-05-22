# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS-Feed/XML-RSS-Feed-2.1.ebuild,v 1.1 2005/05/22 18:20:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Persistant XML RSS Encapsulation"
HOMEPAGE="http://search.cpan.org/~jbisbee/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JB/JBISBEE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/HTML-Parser
		dev-perl/XML-RSS
		dev-perl/Clone
		dev-perl/Time-HiRes
		dev-perl/URI
		dev-perl/Digest-MD5"
