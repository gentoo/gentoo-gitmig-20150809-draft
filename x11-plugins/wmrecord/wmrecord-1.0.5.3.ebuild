# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmrecord/wmrecord-1.0.5.3.ebuild,v 1.1 2004/07/19 08:13:38 s4t4n Exp $

IUSE=""

DESCRIPTION="A Dockable General Purpose Recording Utility"
SRC_URI="http://ret009t0.eresmas.net/other_software/wmrecord/${PN}-1.0.5_20040218_0029.tgz"
HOMEPAGE="http://ret009t0.eresmas.net/other_software/wmrecord/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S=${WORKDIR}/${PN}-1.0.5

src_compile()
{
	emake CFLAGS="${CFLAGS} -Wall" || die "make failed"
}

src_install()
{
	dodir /usr/bin
	dodir /usr/share/man
	einstall BINDIR="${D}/usr/bin" MANDIR="${D}/usr/share/man" || die "make install failed"
	prepallman

	dodoc Changelog README TODO

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
