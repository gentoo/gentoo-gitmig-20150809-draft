# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/version/version-0.67.01.ebuild,v 1.2 2006/10/20 17:58:43 mcummings Exp $

inherit versionator perl-module

MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Perl extension for Version Objects"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/J/JP/JPEACOCK/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/module-build-0.28
	dev-lang/perl"
