# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ooodi/ooodi-0.61.ebuild,v 1.1 2003/06/06 19:26:07 pauldv Exp $

MY_P="OOodi2-${PV}"
DESCRIPTION="automated dictionary installer for OpenOffice"
SRC_URI="mirror://sourceforge/ooodi/${MY_P}.tar.gz"
HOMEPAGE="http://ooodi.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="net-ftp/curl
	=x11-libs/gtk+-2*"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
