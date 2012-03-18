# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-ExtUtils-Command/perl-ExtUtils-Command-1.170.0-r2.ebuild,v 1.7 2012/03/18 18:02:41 armin76 Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.14* ~perl-core/${PN#perl-}-${PV} )"
