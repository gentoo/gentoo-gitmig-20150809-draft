# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Memoize/perl-Memoize-1.20.0-r1.ebuild,v 1.5 2012/01/01 17:52:24 armin76 Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.14* ~perl-core/${PN#perl-}-${PV} )"
