# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpeople/wmpeople-1.2.ebuild,v 1.2 2004/06/30 07:45:43 dholm Exp $

inherit eutils

DESCRIPTION="Nice, highly configurable WMaker DockApp that monitors your mail boxes"
HOMEPAGE="http://peephole.sourceforge.net/"
SRC_URI="mirror://sourceforge/peephole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

# This program supports the nptl, but there is no need
# for ebuild code to enable it...
IUSE="nptl"

DEPEND="
	virtual/x11
	>=net-mail/peephole-1.2"

src_install()
{
	einstall || die "Installation failed"
	dodoc AUTHORS COPYING ChangeLog README
}

pkg_postinst()
{
	einfo "Before you can use wmpeople you must copy"
	einfo "/etc/skel/.wmpeoplerc to your home dir"
	einfo "and edit it to suit your needs."
	einfo "Also, make sure that the peephole daemon"
	einfo "is up and running before you start wmpeople."
	sleep 5
}
