# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageInfo/ImageInfo-1.15.ebuild,v 1.2 2003/12/27 23:16:37 mcummings Exp $

inherit perl-module

MY_P=Image-Info-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl Image-Info Module"
SRC_URI="http://www.cpan.org/modules/by-module/Image/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc sparc ~alpha"

DEPEND="${DEPEND}
	>=dev-perl/IO-String-1.01"
