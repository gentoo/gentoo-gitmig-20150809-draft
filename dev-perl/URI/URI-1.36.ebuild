# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI/URI-1.36.ebuild,v 1.1 2008/04/29 14:53:44 tove Exp $

MODULE_AUTHOR=GAAS

inherit perl-module

DESCRIPTION="A URI Perl Module"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/perl-MIME-Base64
	dev-lang/perl"

SRC_TEST=do

mydoc="rfc2396.txt"
