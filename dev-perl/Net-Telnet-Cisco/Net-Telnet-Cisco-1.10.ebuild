# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet-Cisco/Net-Telnet-Cisco-1.10.ebuild,v 1.20 2009/10/22 12:48:12 tove Exp $

MODULE_AUTHOR=JOSHUA
inherit perl-module

DESCRIPTION="Automate telnet sessions w/ routers&switches"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/Net-Telnet
	dev-perl/TermReadKey
	dev-lang/perl"

PATCHES=( "${FILESDIR}/${PV}-warning.patch" )
