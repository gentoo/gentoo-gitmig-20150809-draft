# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/X11-Protocol/X11-Protocol-0.53.ebuild,v 1.4 2005/04/01 04:45:58 agriffis Exp $

inherit perl-module eutils

DESCRIPTION="Client-side interface to the X11 Protocol"
HOMEPAGE="http://www.cpan.org/modules/by-module/X11/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/X11/${P}.tar.gz"

LICENSE="Artistic X11"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~ppc ~sparc ~x86 ppc64"
IUSE=""

DEPEND="virtual/x11"
