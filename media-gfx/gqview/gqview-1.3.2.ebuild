# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-1.3.2.ebuild,v 1.1 2003/06/14 05:47:33 avenj Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="A GTK-based image browser"
SRC_URI="mirror://sourceforge/gqview/${P}.tar.gz"
HOMEPAGE="http://gqview.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="media-libs/libpng
	>=x11-libs/gtk+-2.2.0"
	
RDEPEND="nls? ( sys-devel/gettext )"


src_compile() {
	local myconf
	
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall GNOME_DATADIR=${D}/usr/share || die

	# remove duplicate README, since it gets installed in dodoc
	rm -rf ${D}/usr/share/gqview
	
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
