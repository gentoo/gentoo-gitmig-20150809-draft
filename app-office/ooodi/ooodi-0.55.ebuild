# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ooodi/ooodi-0.55.ebuild,v 1.4 2004/03/02 21:35:12 augustus Exp $

MY_P="OOodi-${PV}"
DESCRIPTION="automated dictionary installer for OpenOffice"
SRC_URI="mirror://sourceforge/ooodi/${MY_P}.tar.gz"
HOMEPAGE="http://ooodi.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="nls"

DEPEND="net-ftp/curl
	=x11-libs/gtk+-1*"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
