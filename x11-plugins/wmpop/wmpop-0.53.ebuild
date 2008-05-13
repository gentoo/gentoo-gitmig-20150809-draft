# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpop/wmpop-0.53.ebuild,v 1.8 2008/05/13 07:24:52 s4t4n Exp $

IUSE=""

DESCRIPTION="WMpop is a Window Maker DockApp for monitoring a local (mbox format) or POP3 and APOP mailbox."
SRC_URI="http://jsautret.free.fr/wmpop/${P}.tar.gz"
HOMEPAGE="http://wmpop.sautret.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="sparc x86"

DEPEND="=x11-libs/gtk+-1.2*
	sys-devel/bison
	media-sound/esound"

RDEPEND="=x11-libs/gtk+-1.2*
	media-sound/esound"

src_install() {
	einstall || die "Install failed"
	dodoc AUTHORS README ChangeLog NEWS TODO THANKS
}
