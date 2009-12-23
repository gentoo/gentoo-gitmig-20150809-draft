# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDGraph/GDGraph-1.44.ebuild,v 1.8 2009/12/23 19:01:35 grobian Exp $

MODULE_AUTHOR=BWARFIELD
inherit perl-module

DESCRIPTION="perl5 module to create charts using the GD module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

DEPEND="dev-perl/GDTextUtil
	dev-perl/GD
	media-libs/gd
	dev-lang/perl"
