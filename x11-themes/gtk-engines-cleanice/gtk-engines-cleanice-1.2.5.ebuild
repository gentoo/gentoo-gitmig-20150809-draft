# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-cleanice/gtk-engines-cleanice-1.2.5.ebuild,v 1.6 2004/07/15 01:03:24 agriffis Exp $

inherit gtk-engines2

IUSE=""
DESCRIPTION="GTK+2 Cleanice Theme Engine"
HOMEPAGE="http://sourceforge.net/project/elysium-project/"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"
KEYWORDS="x86 ppc ~sparc ~alpha amd64"
LICENSE="GPL-2"
SLOT="2"

DEPEND=">=x11-libs/gtk+-2"
