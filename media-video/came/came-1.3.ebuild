# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/came/came-1.3.ebuild,v 1.4 2004/03/29 01:04:12 vapier Exp $

DESCRIPTION="camE is a rewrite of the xawtv webcam app, which adds imlib2 support and a lot of new features"
HOMEPAGE="http://linuxbrit.co.uk/camE/"
SRC_URI="http://linuxbrit.co.uk/downloads/camE-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=net-misc/curl-7.9.1
	>=media-libs/giblib-1.2.1"

S=${WORKDIR}/camE-${PV}

src_compile() {
	mv Makefile Makefile_old
	sed -e "s:/usr/local:/usr:" Makefile_old > Makefile
	emake || die
}

src_install() {
	insinto /usr
	dobin camE || die
	dodoc AUTHORS
	dodoc camE_text.style
	dodoc camE_title.style
	dodoc example.camErc
	dodoc example.camErc.ssh
}
