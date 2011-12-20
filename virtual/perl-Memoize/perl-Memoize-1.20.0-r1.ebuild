# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Memoize/perl-Memoize-1.20.0-r1.ebuild,v 1.3 2011/12/20 20:40:23 jer Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.14* ~perl-core/${PN#perl-}-${PV} )"
