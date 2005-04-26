# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-AutoInstall/ExtUtils-AutoInstall-0.61.ebuild,v 1.3 2005/04/26 19:48:47 kloeri Exp $

IUSE=""

inherit perl-module

DESCRIPTION="Allows module writers to specify a more sophisticated form of dependency information"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~autrijus/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~ppc sparc alpha"

SRC_TEST="do"

DEPEND="dev-perl/Sort-Versions"


src_compile() {
	echo "n" | perl-module_src_compile
}
