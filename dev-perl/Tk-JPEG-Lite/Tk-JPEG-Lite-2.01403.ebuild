# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-JPEG-Lite/Tk-JPEG-Lite-2.01403.ebuild,v 1.1 2005/01/22 21:04:31 luckyduck Exp $

inherit perl-module

IUSE=""

S=${WORKDIR}/Tk-JPEG-Lite-2.01403
DESCRIPTION="No description available."
SRC_URI="http://www.cpan.org/modules/by-authors/id/S/SR/SREZIC/Tk-JPEG-Lite-2.01403.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SR/SREZIC/${P}.readme"

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc"

DEPEND="dev-perl/perl-tk"

