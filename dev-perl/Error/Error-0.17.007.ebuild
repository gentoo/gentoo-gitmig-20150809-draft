# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Error/Error-0.17.007.ebuild,v 1.2 2006/10/23 20:09:54 mcummings Exp $

inherit versionator perl-module

MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Error/exception handling in an OO-ish way"
HOMEPAGE="http://www.cpan.org/modules/by-module/Error/"
SRC_URI="mirror://cpan/authors/id/S/SH/SHLOMIF/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
		dev-perl/module-build"
RDEPEND="dev-lang/perl"

SRC_TEST="do"
