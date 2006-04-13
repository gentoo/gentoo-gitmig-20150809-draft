# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gtkesms/gtkesms-0.0.4.ebuild,v 1.3 2006/04/13 19:29:44 mrness Exp $

inherit eutils

DESCRIPTION="GTK GUI for esms"
SRC_URI="mirror://sourceforge/esms/${P}.tar.gz"
HOMEPAGE="http://esms.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="sparc x86"

DEPEND="=x11-libs/gtk+-1.2*
		dev-perl/gtk-perl
		app-mobilephone/esms"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/gtkesms.patch"
}

src_install () {
	make DESTDIR="${D}" install || die "install failed"
}
