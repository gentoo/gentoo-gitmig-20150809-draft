# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-locale-maketext/perl-locale-maketext-1.190.0-r1.ebuild,v 1.4 2011/12/21 22:04:14 maekke Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"

IUSE=""
RDEPEND="|| ( =dev-lang/perl-5.14* ~perl-core/${PN#perl-}-${PV} )"
