# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/q7z/q7z-0.7.1.ebuild,v 1.1 2008/02/18 23:33:51 yngwin Exp $

MY_PN="Q7Z"
DESCRIPTION="A GUI frontend for p7zip"
HOMEPAGE="http://k7z.sourceforge.net/7Z/Q7Z/"
SRC_URI="mirror://sourceforge/k7z/${MY_PN}-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="app-arch/p7zip
	app-arch/tar
	>=dev-python/PyQt4-4.3"

S="${WORKDIR}/${MY_PN}/Build"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	rm ../Doc/COPYING.txt ../Doc/LICENCE.txt   # unneeded GPL copies
	dodoc ../Doc/*
	rm -rf "${D}"/usr/share/apps/Q7Z/Doc   # which is now superfluous
}
