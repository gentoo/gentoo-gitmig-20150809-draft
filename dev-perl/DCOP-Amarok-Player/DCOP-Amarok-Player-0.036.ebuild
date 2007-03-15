# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DCOP-Amarok-Player/DCOP-Amarok-Player-0.036.ebuild,v 1.3 2007/03/15 08:27:55 tove Exp $

inherit perl-module

DESCRIPTION="Perl interface to Amarok via dcop"
SRC_URI="mirror://cpan/authors/id/J/JC/JCMULLER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JC/JCMULLER/${P}.readme"

RDEPEND="dev-perl/DCOP-Amarok"

IUSE=""

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 x86"

#Tests disabled - comment back if you are testing and are running an active KDE
# session
# ~mcummings
#SRC_TEST="do"
