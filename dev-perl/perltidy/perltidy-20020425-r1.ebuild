# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20020425-r1.ebuild,v 1.4 2003/02/13 11:28:33 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P/perltidy/Perl-Tidy}
DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"
SRC_URI="mirror://sourceforge/perltidy/${P/perltidy/Perl-Tidy}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}"

mymake="/usr"
