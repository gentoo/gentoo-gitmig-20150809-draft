# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Simple/Config-Simple-4.58.ebuild,v 1.5 2006/03/30 22:23:32 agriffis Exp $

inherit perl-module

DESCRIPTION="Config::Simple - simple configuration file class."
SRC_URI="mirror://cpan/authors/id/S/SH/SHERZODR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~sherzodr/${P}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"
