# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.21.ebuild,v 1.5 2004/07/14 16:57:15 agriffis Exp $


inherit perl-module

MY_P=Config-General-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Config file parser module"
SRC_URI="http://www.cpan.org/CPAN/authors/id/T/TL/TLINDEN/${MY_P}.tar.gz"
HOMEPAGE="http://www.daemon.de/config-general/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc sparc alpha"
IUSE=""
