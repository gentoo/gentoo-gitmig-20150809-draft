# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnomemm/gnomemm-1.2.3-r1.ebuild,v 1.11 2004/03/19 10:09:17 aliz Exp $

inherit gcc eutils

S=${WORKDIR}/${P}
DESCRIPTION="C++ binding for the GNOME libraries"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc x86 sparc alpha hppa amd64 ia64"

RDEPEND="=dev-cpp/gtkmm-1.2*
	>=gnome-base/gnome-libs-1.4
	>=gnome-base/ORBit-0.5.11
	=sys-libs/db-1*"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A} ; cd ${S}
	# http://bugzilla.gnome.org/show_bug.cgi?id=121307 gcc 3.3.x (#27061)
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
