# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpop/wmpop-0.53.ebuild,v 1.9 2008/07/28 07:39:42 s4t4n Exp $

IUSE=""

DESCRIPTION="WMpop is a Window Maker DockApp for monitoring a local (mbox format) or POP3 and APOP mailbox."
SRC_URI="http://jsautret.free.fr/wmpop/${P}.tar.gz"
HOMEPAGE="http://wmpop.sautret.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="sparc x86"

RDEPEND="=x11-libs/gtk+-1.2*
	media-sound/esound
	x11-libs/libXpm"

DEPEND="${RDEPEND}
	sys-devel/bison"

src_install() {
	einstall || die "Install failed"
	dodoc AUTHORS README ChangeLog NEWS TODO THANKS
}
