# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-magicchicken/gtk-engines-magicchicken-1.1.1.ebuild,v 1.3 2004/02/07 00:25:34 agriffis Exp $

inherit gtk-engines2

IUSE=""
DESCRIPTION="GTK+2.2 Magic Chicken Theme Engine"
HOMEPAGE="http://esco.mine.nu/misc/themes.html"
SRC_URI="http://esco.mine.nu/downloads/mgicchikn-${PV}.tar.gz"
KEYWORDS="x86 ~ppc ~sparc alpha"
LICENSE="GPL-2"
SLOT="2"

DEPEND=">=x11-libs/gtk+-2.2"

S=${WORKDIR}/mgicchikn-${PV}

