# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/interceptty/interceptty-0.6.ebuild,v 1.2 2006/04/23 19:24:08 malc Exp $

DESCRIPTION="interceptty is a program that can sit between a real (or fake!) serial port and an application, recording any communications between the application and the device."
HOMEPAGE="http://www.suspectclass.com/~sgifford/interceptty/"
SRC_URI="http://www.suspectclass.com/~sgifford/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	into /usr
	dobin interceptty interceptty-nicedump
	dodoc AUTHORS NEWS README TODO
	doman interceptty.1
}
