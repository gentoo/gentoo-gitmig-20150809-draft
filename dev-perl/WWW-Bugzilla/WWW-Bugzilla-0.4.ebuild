# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Bugzilla/WWW-Bugzilla-0.4.ebuild,v 1.8 2005/07/09 23:22:05 swegener Exp $

inherit perl-module

DESCRIPTION="automate interaction with bugzilla"
SRC_URI="mirror://cpan/authors/id/M/MC/MCVELLA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mcvella/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

RDEPEND="dev-perl/WWW-Mechanize
		<dev-perl/Class-MethodMaker-2"

DEPEND="${RDEPEND}"
