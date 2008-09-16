# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-ASN1/Convert-ASN1-0.22.ebuild,v 1.1 2008/09/16 10:23:01 tove Exp $

MODULE_AUTHOR=GBARR
inherit perl-module

DESCRIPTION="Standard en/decode of ASN.1 structures"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"
DEPEND="dev-lang/perl"
