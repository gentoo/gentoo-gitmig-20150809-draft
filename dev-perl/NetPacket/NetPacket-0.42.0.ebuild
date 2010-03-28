# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/NetPacket/NetPacket-0.42.0.ebuild,v 1.1 2010/03/28 00:12:16 robbat2 Exp $

MODULE_AUTHOR=YANICK
MY_P="${PN}-v${PV}"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Perl NetPacket - network packets assembly/disassembly"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
