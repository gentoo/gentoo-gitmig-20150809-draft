# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/simgear/simgear-0.3.1.ebuild,v 1.2 2002/12/31 16:44:23 vapier Exp $

MY_P=SimGear-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="mirror://simgear/Source/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="X gnome"

DEPEND="media-libs/plib
	dev-db/metakit"

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodoc README* NEWS AUTHORS ChangeLog
}
