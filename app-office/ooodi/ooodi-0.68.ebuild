# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ooodi/ooodi-0.68.ebuild,v 1.10 2005/03/30 20:08:41 gustavoz Exp $

MY_P="OOodi2-${PV}"
DESCRIPTION="automated dictionary installer for OpenOffice"
HOMEPAGE="http://ooodi.sourceforge.net/"
SRC_URI="mirror://sourceforge/ooodi/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE="nls"

DEPEND="net-misc/curl
	=x11-libs/gtk+-2*
	gnome-base/libglade"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
