# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/X11-Protocol/X11-Protocol-0.52.ebuild,v 1.3 2004/02/01 21:31:48 avenj Exp $

inherit perl-module eutils

S=${WORKDIR}/${P}
DESCRIPTION="Client-side interface to the X11 Protocol"
SRC_URI="http://www.cpan.org/modules/by-module/X11/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/X11/${P}.readme"

SLOT="0"
LICENSE="Artistic X11"
KEYWORDS="x86 alpha sparc amd64"

DEPEND="${DEPEND} virtual/x11"
