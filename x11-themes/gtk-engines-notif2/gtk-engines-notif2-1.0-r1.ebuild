# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-notif2/gtk-engines-notif2-1.0-r1.ebuild,v 1.8 2007/01/05 09:28:05 flameeyes Exp $

DESCRIPTION="GTK+1 Notif2 Theme Engine"
HOMEPAGE="http://themes.freshmeat.net/projects/notif210/"
SRC_URI="http://download.freshmeat.net/themes/notif210/notif210-1.2.tar.gz"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"
LICENSE="GPL-2"
SLOT="1"
IUSE="static"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/notif2-${PV}

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog README TODO
}
