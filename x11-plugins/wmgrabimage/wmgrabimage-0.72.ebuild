# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmgrabimage/wmgrabimage-0.72.ebuild,v 1.1 2004/07/19 07:56:38 s4t4n Exp $

inherit eutils

IUSE=""

MY_P=${PN/grabi/GrabI}
S=${WORKDIR}/${MY_P}-${PV}/${MY_P}

DESCRIPTION="wmGrabImage grabs an image from the WWW and displays it"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${MY_P}-${PV}.tgz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

DEPEND="virtual/x11
	>=net-misc/wget-1.9-r2
	>=media-gfx/imagemagick-5.5.7.15"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack()
{
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-noman.patch
}

src_compile()
{
	emake clean || die "clean failed"
	emake CFLAGS="${CFLAGS} -Wall" || die "make failed"
}

src_install()
{
	cd ${S}
	dodir /usr/bin
	einstall DESTDIR="${D}/usr" || die "make install failed"

	doman wmGrabImage.1

	cd ..
	dodoc BUGS CHANGES HINTS TODO

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
