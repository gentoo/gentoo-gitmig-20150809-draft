# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-template/text-template-1.44.ebuild,v 1.6 2004/10/16 23:57:25 rac Exp $

inherit perl-module

MY_P=Text-Template-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Expand template text with embedded Perl"
SRC_URI="http://www.cpan.org/authors/id/M/MJ/MJD/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MJ/MJD/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~ppc sparc alpha ~hppa"
IUSE=""

DEPEND="${DEPEND}"
