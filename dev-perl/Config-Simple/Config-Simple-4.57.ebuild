# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Simple/Config-Simple-4.57.ebuild,v 1.1 2004/10/28 14:45:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Config::Simple - simple configuration file class."
SRC_URI="mirror://cpan/authors/id/S/SH/SHERZODR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/S/SH/SHERZODR/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

SRC_TEST="do"
