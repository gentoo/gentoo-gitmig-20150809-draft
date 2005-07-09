# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20020425-r1.ebuild,v 1.9 2005/07/09 22:50:43 swegener Exp $

inherit perl-module

S=${WORKDIR}/${P/perltidy/Perl-Tidy}
DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"
SRC_URI="mirror://sourceforge/perltidy/${P/perltidy/Perl-Tidy}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

mymake="/usr"
