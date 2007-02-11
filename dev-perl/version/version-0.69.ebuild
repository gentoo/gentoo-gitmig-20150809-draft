# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/version/version-0.69.ebuild,v 1.4 2007/02/11 10:32:52 vapier Exp $

inherit versionator perl-module

MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Perl extension for Version Objects"
HOMEPAGE="http://search.cpan.org/~jpeakcock"
SRC_URI="mirror://cpan/authors/id/J/JP/JPEACOCK/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/module-build-0.28
	dev-lang/perl"

SRC_TEST="do"
