# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-0.3.2.ebuild,v 1.1 2003/02/21 21:56:34 phoenix Exp $

inherit gnome2 debug

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="CDR plugin for Nautilus"
SRC_URI="http://ftp.acc.umu.se/pub/GNOME/sources/nautilus-cd-burner/0.3/${P}.tar.gz"
HOMEPAGE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/nautilus-2.1
		 >=gnome-base/gnome-vfs-2.1.3"

DEPEND=">=dev-util/intltool-0.18
	>=dev-util/pkgconfig-0.12.0
	${RDEPEND}"


DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"


