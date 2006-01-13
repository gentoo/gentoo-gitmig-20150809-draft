# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Jcode/Jcode-2.03.ebuild,v 1.1 2006/01/13 14:55:08 mcummings Exp $

inherit perl-module

MY_P=Jcode-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Japanese transcoding module for Perl"
SRC_URI="mirror://cpan/authors/id/D/DA/DANKOGAI/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-authors/id/D/DA/DANKOGAI/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=perl-core/MIME-Base64-2.1"
