# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomemm/libgnomemm-2.0.0-r1.ebuild,v 1.10 2005/01/01 17:28:34 eradicator Exp $

inherit gnome2 eutils
IUSE=""

DESCRIPTION="C++ bindings for libgnome"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"

KEYWORDS="x86 ~ppc sparc amd64"
SLOT="2"

RDEPEND="=dev-cpp/gtkmm-2.2*
	>=gnome-base/libgnome-2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"

src_unpack() {
	unpack ${A}
	# patch to fix typo in .pc files
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P}-pkgconfig.patch
}
