# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/NetPacket/NetPacket-0.04.ebuild,v 1.4 2006/10/21 14:28:59 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Perl NetPacket - network packets assembly/disassembly"
SRC_URI="mirror://cpan/authors/id/A/AT/ATRAK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/NetPacket/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ppc ~x86"
SRC_TEST="do"


DEPEND="dev-lang/perl"
