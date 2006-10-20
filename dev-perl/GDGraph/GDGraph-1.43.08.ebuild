# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDGraph/GDGraph-1.43.08.ebuild,v 1.9 2006/10/20 19:24:01 kloeri Exp $

inherit perl-module

MY_PV=${PV/43.08/4308}
MY_P="$PN-$MY_PV"
S=${WORKDIR}/${MY_P}

DESCRIPTION="perl5 module to create charts using the GD module"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/B/BW/BWARFIELD/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-perl/GDTextUtil
	dev-perl/GD
	media-libs/gd
	dev-lang/perl"
