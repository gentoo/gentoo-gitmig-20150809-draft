# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpop/wmpop-0.53.ebuild,v 1.4 2004/11/25 05:40:21 weeve Exp $

IUSE=""

DESCRIPTION="WMpop is a Window Maker  DockApp for monitoring a local (mbox format) or POP3 and APOP mailbox."
SRC_URI="http://jsautret.free.fr/wmpop/${P}.tar.gz"
HOMEPAGE="http://wmpop.sautret.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	sys-devel/gettext
	sys-devel/bison
	media-sound/esound"

src_compile() {
	econf || die "Configure failed."
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc AUTHORS COPYING README ChangeLog NEWS INSTALL TODO THANKS ABOUT-NLS
}
