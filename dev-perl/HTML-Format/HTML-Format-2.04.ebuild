# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Format/HTML-Format-2.04.ebuild,v 1.5 2005/04/09 02:01:35 gustavoz Exp $

# this is an RT dependency
inherit perl-module

DESCRIPTION="HTML Formatter"
SRC_URI="http://www.cpan.org/modules/by-authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SB/SBURKE/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="dev-perl/Font-AFM
	dev-perl/HTML-Tree"
IUSE=""
