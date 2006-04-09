# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x11-ssh-askpass/x11-ssh-askpass-1.2.4.1-r1.ebuild,v 1.5 2006/04/09 03:15:36 tester Exp $

inherit eutils multilib

IUSE=""
DESCRIPTION="X11-based passphrase dialog for use with OpenSSH"
HOMEPAGE="http://www.liquidmeme.net/software/x11-ssh-askpass/"
SRC_URI="http://www.liquidmeme.net/software/x11-ssh-askpass/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ~ppc ~sparc ~x86"

DEPEND="virtual/libc
	|| 	(
			(
				app-text/rman
				x11-misc/imake
				x11-libs/libXt
				x11-libs/libX11
				x11-libs/libSM
				x11-libs/libICE
			)
			virtual/x11
		)"
RDEPEND="${DEPEND}
	virtual/ssh"

src_compile() {
	econf --libexecdir=/usr/$(get_libdir)/misc || die
	xmkmf || die
	make includes || die
	make "CDEBUGFLAGS=${CFLAGS}" || die
}

src_install() {
	newman x11-ssh-askpass.man x11-ssh-askpass.1
	dobin x11-ssh-askpass
	dodir /usr/$(get_libdir)/misc
	dosym /usr/bin/x11-ssh-askpass /usr/$(get_libdir)/misc/ssh-askpass
	dodoc ChangeLog README TODO
}
