# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-cleanice/gtk-engines-cleanice-1.2.7.ebuild,v 1.10 2004/07/15 01:03:24 agriffis Exp $

inherit gtk-engines2

IUSE=""
DESCRIPTION="GTK+2 Cleanice Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/elysium-project/"
SRC_URI="mirror://sourceforge/elysium-project/cleanice-theme-${PV}.tar.gz"
KEYWORDS="x86 ppc sparc alpha ia64 hppa amd64"
LICENSE="GPL-2"
SLOT="2"
S=${WORKDIR}/cleanice-theme-${PV}

DEPEND=">=x11-libs/gtk+-2"
