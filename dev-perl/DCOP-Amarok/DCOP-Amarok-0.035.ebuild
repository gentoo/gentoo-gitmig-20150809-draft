# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DCOP-Amarok/DCOP-Amarok-0.035.ebuild,v 1.1 2006/10/24 00:34:54 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl Interface to Amarok via system's dcop"
SRC_URI="mirror://cpan/authors/id/J/JC/JCMULLER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JC/JCMULLER/${P}.readme"

RDEPEND="dev-perl/DCOP
	media-sound/amarok"
	
IUSE=""
	
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~x86"
	
SRC_TEST="do"
