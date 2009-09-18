# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Simple/Email-Simple-2.005.ebuild,v 1.6 2009/09/18 17:13:32 tove Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Simple parsing of RFC2822 message format and headers"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
