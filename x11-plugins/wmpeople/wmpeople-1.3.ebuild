# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpeople/wmpeople-1.3.ebuild,v 1.2 2004/07/24 10:57:32 s4t4n Exp $

inherit eutils

DESCRIPTION="Nice, highly configurable WMaker DockApp that monitors your mail boxes"
HOMEPAGE="http://peephole.sourceforge.net/"
SRC_URI="mirror://sourceforge/peephole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="
	virtual/x11
	>=net-mail/peephole-1.2"

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	einfo "Before you can use wmpeople you must copy"
	einfo "/etc/skel/.wmpeoplerc to your home dir"
	einfo "and edit it to suit your needs."
	einfo "Also, make sure that the peephole daemon"
	einfo "is up and running before you start wmpeople."
}
