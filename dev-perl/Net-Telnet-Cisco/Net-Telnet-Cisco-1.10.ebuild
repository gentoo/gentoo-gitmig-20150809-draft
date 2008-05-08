# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet-Cisco/Net-Telnet-Cisco-1.10.ebuild,v 1.18 2008/05/08 19:57:26 tove Exp $

inherit perl-module

DESCRIPTION="Automate telnet sessions w/ routers&switches"
HOMEPAGE="http://search.cpan.org/~joshua/"
SRC_URI="mirror://cpan/authors/id/J/JO/JOSHUA/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/Net-Telnet
	dev-perl/TermReadKey
	dev-lang/perl"

PATCHES="${FILESDIR}/${PV}-warning.patch"
