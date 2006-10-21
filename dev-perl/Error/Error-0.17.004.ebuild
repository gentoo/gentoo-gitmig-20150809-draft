# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Error/Error-0.17.004.ebuild,v 1.6 2006/10/21 14:07:56 dertobi123 Exp $

inherit versionator perl-module

MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Error/exception handling in an OO-ish way"
HOMEPAGE="http://www.cpan.org/modules/by-module/Error/"
SRC_URI="mirror://cpan/authors/id/P/PE/PEVANS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ~ppc64 s390 sh sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
