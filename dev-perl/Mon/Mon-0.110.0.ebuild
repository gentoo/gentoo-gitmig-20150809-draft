# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mon/Mon-0.110.0.ebuild,v 1.2 2011/09/03 21:05:09 tove Exp $

EAPI=4

MODULE_AUTHOR=TROCKIJ
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="A Monitor Perl Module"

SLOT="0"
LICENSE="|| ( GPL-2 GPL-3 )" # GPL2+
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=net-analyzer/fping-2.2_beta1
	>=dev-perl/Convert-BER-1.31
	>=dev-perl/Net-Telnet-3.02
	>=dev-perl/Period-1.20"
DEPEND="${RDEPEND}"

mydoc="COPYING COPYRIGHT VERSION"
