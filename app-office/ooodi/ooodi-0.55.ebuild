# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ooodi/ooodi-0.55.ebuild,v 1.7 2005/01/01 15:37:37 eradicator Exp $

MY_P="OOodi-${PV}"
DESCRIPTION="automated dictionary installer for OpenOffice"
HOMEPAGE="http://ooodi.sourceforge.net/"
SRC_URI="mirror://sourceforge/ooodi/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="nls"

DEPEND="net-misc/curl
	=x11-libs/gtk+-1*"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
