# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20020425-r1.ebuild,v 1.2 2002/12/09 04:21:12 manson Exp $

inherit perl-module

S=${WORKDIR}/${P/perltidy/Perl-Tidy}
DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"
SRC_URI="mirror://sourceforge/perltidy/${P/perltidy/Perl-Tidy}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc  alpha"

DEPEND="${DEPEND}"

mymake="/usr"
