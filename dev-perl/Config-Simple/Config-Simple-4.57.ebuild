# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Simple/Config-Simple-4.57.ebuild,v 1.3 2005/03/30 17:42:45 gustavoz Exp $

inherit perl-module

DESCRIPTION="Config::Simple - simple configuration file class."
SRC_URI="mirror://cpan/authors/id/S/SH/SHERZODR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/S/SH/SHERZODR/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~ppc sparc"
IUSE=""

SRC_TEST="do"
