# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/NetPacket/NetPacket-0.43.0.ebuild,v 1.4 2010/06/27 19:14:55 nixnut Exp $

EAPI=3

MODULE_AUTHOR=YANICK
MY_P="${PN}-v${PV}"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Perl NetPacket - network packets assembly/disassembly"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
