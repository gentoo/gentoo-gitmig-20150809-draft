# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet-Cisco/Net-Telnet-Cisco-1.10.ebuild,v 1.1 2003/06/04 01:18:06 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Automate telnet sessions w/ routers&switches"
SRC_URI="http://www.cpan.org/modules/by-authors/id/J/JO/JOSHUA/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JO/JOSHUA/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~arm ~hppa ~mips ~ppc ~sparc"

DEPEND="dev-perl/Net-Telnet
		dev-perl/TermReadKey"

