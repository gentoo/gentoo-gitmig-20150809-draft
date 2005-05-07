# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IniConf/IniConf-1.03.ebuild,v 1.2 2005/05/07 03:12:09 gustavoz Exp $

inherit perl-module

DESCRIPTION="A Module for reading .ini-style configuration files"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RB/RBOW/${P}.readme"
IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~sparc"

SRC_TEST="do"

DEPEND="dev-perl/Config-IniFiles"
