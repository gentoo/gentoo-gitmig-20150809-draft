# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnomemm/gnomemm-1.2.3-r1.ebuild,v 1.2 2003/06/24 02:38:06 lu_zero Exp $

inherit gcc

S=${WORKDIR}/${P}
DESCRIPTION="C++ binding for the GNOME libraries"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc x86 sparc alpha"

RDEPEND="=x11-libs/gtkmm-1.2*
	>=gnome-base/ORBit-0.5.11
	=sys-libs/db-1*"

DEPEND="${RDEPEND}"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
