# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DCOP-Amarok-Player/DCOP-Amarok-Player-0.037.ebuild,v 1.1 2009/08/25 17:24:01 robbat2 Exp $

MODULE_AUTHOR="JCMULLER"
inherit perl-module

DESCRIPTION="Perl interface to Amarok via dcop"

RDEPEND="dev-perl/DCOP-Amarok"

IUSE=""

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

#Tests disabled - comment back if you are testing and are running an active KDE
# session
# ~mcummings
#SRC_TEST="do"
