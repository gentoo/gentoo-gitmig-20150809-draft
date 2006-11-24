# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DCOP-Amarok/DCOP-Amarok-0.035.ebuild,v 1.2 2006/11/24 17:16:38 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl Interface to Amarok via system's dcop"
SRC_URI="mirror://cpan/authors/id/J/JC/JCMULLER/${P}.tar.gz"
HOMEPAGE="http://searcy.cpan.org/~jcmuller/"

RDEPEND="dev-perl/DCOP
	media-sound/amarok"

IUSE=""

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~x86"

SRC_TEST="do"
