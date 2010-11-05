# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Digest-SHA/perl-Digest-SHA-5.47.ebuild,v 1.13 2010/11/05 11:14:42 maekke Exp $

DESCRIPTION="Perl extension for SHA-1/224/256/384/512"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.12.2 ~dev-lang/perl-5.12.1 ~dev-lang/perl-5.10.1 ~perl-core/Digest-SHA-${PV} )"
