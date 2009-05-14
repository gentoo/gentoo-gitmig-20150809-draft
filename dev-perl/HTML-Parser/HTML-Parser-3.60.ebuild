# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Parser/HTML-Parser-3.60.ebuild,v 1.3 2009/05/14 17:00:11 jer Exp $

MODULE_AUTHOR=GAAS
inherit perl-module

DESCRIPTION="Parse <HEAD> section of HTML documents"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-perl/HTML-Tagset-3.03
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
mydoc="ANNOUNCEMENT TODO"
