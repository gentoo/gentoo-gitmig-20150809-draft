# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Digest-SHA/perl-Digest-SHA-5.45.ebuild,v 1.2 2008/11/03 16:43:50 mr_bones_ Exp $

DESCRIPTION="Perl extension for SHA-1/224/256/384/512"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.0 ~perl-core/Digest-SHA-${PV} )"
