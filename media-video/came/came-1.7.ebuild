# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/came/came-1.7.ebuild,v 1.1 2003/12/29 10:58:33 mholzer Exp $

S=${WORKDIR}/camE-${PV}
DESCRIPTION="camE is a rewrite of the xawtv webcam app, which adds imlib2 support and a lot of new features"
SRC_URI="http://linuxbrit.co.uk/downloads/camE-${PV}.tar.gz"
HOMEPAGE="http://linuxbrit.co.uk/camE/"

DEPEND=">=net-ftp/curl-7.9.1
	>=media-libs/giblib-1.2.3"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	sed -i -e "s:/usr/local:/usr:" Makefile
	emake || die
}

src_install () {
	insinto /usr
	dobin camE
	dodoc AUTHORS
	dodoc camE_text.style
	dodoc camE_title.style
	dodoc example.camErc
	dodoc example.camErc.ssh
}
