# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-0.97.ebuild,v 1.1 2003/06/04 01:01:25 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Detect browser, version, OS from UserAgent"
SRC_URI="http://www.cpan.org/modules/by-authors/id/L/LH/LHS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/L/LH/LHS/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~arm ~hppa ~mips ~ppc ~sparc"

