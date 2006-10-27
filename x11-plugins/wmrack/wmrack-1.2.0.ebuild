# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmrack/wmrack-1.2.0.ebuild,v 1.7 2006/10/27 09:04:39 s4t4n Exp $

inherit eutils

IUSE=""
MY_P=${P/2.0/2}

DESCRIPTION="A WindowMaker Dock CD+Sound Applet"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://wmrack.sf.net/"
DEPEND="x11-wm/windowmaker
	x11-libs/libXpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

S=${WORKDIR}/${MY_P}

src_compile()
{
	cd ${S}
	econf --with-x --prefix=/usr --sysconfdir=/etc --x-includes=/usr/include/ --x-libraries=$(get_libdir) || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install()
{
	cd ${S}
	einstall MANDIR=${D}/usr/share/man || die "Installation failed"

	dodoc README TODO WARRANTY

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
