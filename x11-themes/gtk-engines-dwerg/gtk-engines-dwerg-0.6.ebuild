# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-dwerg/gtk-engines-dwerg-0.6.ebuild,v 1.4 2004/02/06 16:47:19 agriffis Exp $

inherit gtk-engines2

IUSE=""
DESCRIPTION="GTK+2 Dwerg Theme Engine"
SRC_URI="http://download.freshmeat.net/themes/dwerg/dwerg-default-${PV}.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/projects/dwerg/"
KEYWORDS="x86 alpha"
LICENSE="GPL-2"
SLOT="2"

DEPEND=">=x11-libs/gtk+-2"

src_unpack() {
	# Weird. The file is in bz2 but named gz ??
	cd ${WORKDIR}
	bzcat ${DISTDIR}/${A} | tar xvf -
}
