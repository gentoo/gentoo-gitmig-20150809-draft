# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnomemm/gnomemm-1.2.3.ebuild,v 1.3 2002/08/16 04:13:58 murphy Exp $


S=${WORKDIR}/${P}
DESCRIPTION="C++ binding for the GNOME libraries"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

RDEPEND="=x11-libs/gtkmm-1.2*
		 >=gnome-base/ORBit-0.5.11
		 =sys-libs/db-1*"

DEPEND="${RDEPEND}"

# The following patches seems to be no longer actual
# stroke@gentoo.org
# src_unpack() {
#	
#	unpack ${A}
#
#	cd ${S}/src
#	patch < ${FILESDIR}/${P}-gentoo.patch
#	cd ${S}
#	patch -p1 < ${FILESDIR}/${P}-gentoo.patch2
# }

src_compile() {
	
	./configure --host=${CHOST} \
		--prefix=/usr || die

	emake || die
}

src_install() {

	make DESTDIR=${D} \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
