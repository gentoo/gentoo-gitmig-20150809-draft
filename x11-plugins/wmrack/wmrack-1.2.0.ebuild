# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmrack/wmrack-1.2.0.ebuild,v 1.1 2004/07/17 23:05:10 s4t4n Exp $

IUSE=""
MY_P=${P/2.0/2}

DESCRIPTION="A WindowMaker Dock CD+Sound Applet"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://wmrack.sf.net/"
DEPEND="virtual/x11
	|| ( >=x11-wm/windowmaker-0.62.0
	x11-wm/windowmaker-cvs )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S=${WORKDIR}/${MY_P}

src_compile()
{
	cd ${S}
	econf --with-x --prefix=/usr --sysconfdir=/etc || die "Configuration failed"
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
