# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20020425-r1.ebuild,v 1.1 2002/10/30 07:20:41 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P/perltidy/Perl-Tidy}
DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"
SRC_URI="mirror://sourceforge/perltidy/${P/perltidy/Perl-Tidy}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="${DEPEND}"

mymake="/usr"
