# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rss-glx/rss-glx-0.6.8.ebuild,v 1.2 2003/05/29 09:10:25 seemant Exp $

MY_P=${PN/-/_}-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="OpenGL screensavers, ported to GLX.  Suitable for use with xscreensaver"
HOMEPAGE="http://rss-glx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

DEPEND="x11-base/xfree"

src_compile() {
	econf --bindir=/usr/lib/xscreensaver || die
	emake || die
}

src_install() {
	einstall bindir="${D}/usr/lib/xscreensaver"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README.xscreensaver
}

pkg_postinst() {
	echo
	einfo "Read /usr/share/doc/${PF}/README.xscreensaver.gz for"
	einfo "entries to add to your ~/.xscreensaver file to enable these hacks"
	echo
}
