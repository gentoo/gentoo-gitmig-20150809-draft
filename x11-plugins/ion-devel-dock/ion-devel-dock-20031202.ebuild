# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/ion-devel-dock/ion-devel-dock-20031202.ebuild,v 1.1 2003/12/07 17:01:28 twp Exp $

DESCRIPTION="A dock for the ion-devel window manager"
SRC_URI="http://dsv.su.se/~pelle/ion-dock/ion-devel-dock-${PV}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="=x11-wm/ion-devel-${ION_DEVEL_VERSION}"

ION_DEVEL_VERSION=20031121
inherit ion-devel

src_install() {

	ion-devel_src_install

	dodoc README

}
