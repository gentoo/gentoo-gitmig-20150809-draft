# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pawm/pawm-2.0.3.ebuild,v 1.1 2005/07/02 10:36:10 usata Exp $

DESCRIPTION="A window manager for the X Window system, simple, small and functional"
HOMEPAGE="http://www.pleyades.net/pawm"
SRC_URI="http://www.pleyades.net/pawm/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/x11"

src_compile() {
	./0 --prefix=/usr || die
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS Changelog INSTALL README THANKS

	dodir /etc/X11/Sessions
	echo "/usr/bin/${PN}" > ${D}/etc/X11/Sessions/${PN}
	fperms a+x /etc/X11/Sessions/${PN}

	insinto /usr/share/xsessions
	doins ${FILESDIR}/${PN}.desktop
}


pkg_postinst() {
	einfo "Read /usr/share/doc/${PF}/Install.gz for configuration options."
}
