# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.27.ebuild,v 1.5 2005/05/01 18:25:14 slarti Exp $


inherit perl-module

MY_P=Config-General-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Config file parser module"
SRC_URI="mirror://cpan/authors/id/T/TL/TLINDEN/${MY_P}.tar.gz"
HOMEPAGE="http://www.daemon.de/config-general/"

SLOT="0"
LICENSE="Artistic"
SRC_TEST="do"

KEYWORDS="x86 amd64 ~ppc sparc alpha ~ppc64"
IUSE=""
