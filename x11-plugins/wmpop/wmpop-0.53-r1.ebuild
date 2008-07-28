# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpop/wmpop-0.53-r1.ebuild,v 1.1 2008/07/28 07:54:32 s4t4n Exp $

IUSE="gtk"

DESCRIPTION="WMpop is a Window Maker DockApp for monitoring a local (mbox format) or POP3 and APOP mailbox."
SRC_URI="http://jsautret.free.fr/wmpop/${P}.tar.gz"
HOMEPAGE="http://wmpop.sautret.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~sparc ~x86"

RDEPEND="media-sound/esound
	x11-libs/libXpm
	gtk? ( =x11-libs/gtk+-1.2* )"

DEPEND="${RDEPEND}
	sys-devel/bison"

src_compile()
{
	econf                               \
		`use_enable gtk gtkgui`         \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc AUTHORS README ChangeLog NEWS TODO THANKS
}
