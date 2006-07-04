# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-AutoInstall/ExtUtils-AutoInstall-0.63.ebuild,v 1.8 2006/07/04 08:18:16 ian Exp $

inherit perl-module

DESCRIPTION="Allows module writers to specify a more sophisticated form of dependency information"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~autrijus/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

# TESTS BAD. Wants to write to cpan's config on the live system
#SRC_TEST="do"

DEPEND="dev-perl/Sort-Versions"
RDEPEND="${DEPEND}"

src_compile() {
	echo "n" | perl-module_src_compile
}