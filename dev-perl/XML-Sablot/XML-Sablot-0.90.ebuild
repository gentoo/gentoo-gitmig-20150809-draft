# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.90.ebuild,v 1.17 2005/01/04 14:24:18 mcummings Exp $

inherit perl-module

MY_P=${PN}ron-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module for Sablotron"
SRC_URI="mirror://cpan/authors/id/P/PA/PAVELH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pavelh/${MY_P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=app-text/sablotron-0.60"
