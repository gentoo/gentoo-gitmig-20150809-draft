# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-JPEG-Lite/Tk-JPEG-Lite-2.01403.ebuild,v 1.3 2005/05/09 17:39:10 gustavoz Exp $

inherit perl-module

IUSE=""

DESCRIPTION="lite JPEG loader for Tk::Photo"
SRC_URI="mirror://cpan/authors/id/S/SR/SREZIC/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SR/SREZIC/${P}.readme"

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="~amd64 x86 ~ppc ~sparc"

DEPEND="dev-perl/perl-tk"

