# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet-Cisco/Net-Telnet-Cisco-1.10.ebuild,v 1.3 2004/02/20 22:05:35 vapier Exp $

inherit perl-module

DESCRIPTION="Automate telnet sessions w/ routers&switches"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JO/JOSHUA/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-authors/id/J/JO/JOSHUA/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~arm ~hppa ~mips ~sparc amd64"

DEPEND="dev-perl/Net-Telnet
	dev-perl/TermReadKey"
