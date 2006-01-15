# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpop/wmpop-0.53.ebuild,v 1.7 2006/01/15 17:59:40 nelchael Exp $

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

src_install() {
	einstall || die "Install failed"
	dodoc AUTHORS README ChangeLog NEWS TODO THANKS ABOUT-NLS
}
