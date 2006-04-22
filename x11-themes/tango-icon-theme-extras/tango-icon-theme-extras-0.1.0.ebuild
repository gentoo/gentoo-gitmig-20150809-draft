# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tango-icon-theme-extras/tango-icon-theme-extras-0.1.0.ebuild,v 1.6 2006/04/22 18:24:03 spyderous Exp $

DESCRIPTION="This is an extension to the Tango Icon Theme. It includes Tango icons for iPod Digital Audio Player (DAP) devices and the Dell Pocket DJ DAP."
HOMEPAGE="http://tango-project.org/"
SRC_URI="http://tango-project.org/releases/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="png"

RDEPEND=">=x11-themes/tango-icon-theme-0.6.3"
DEPEND="${DEPEND}"

src_compile() {
	if use png; then
		econf --enable-png-creation || die "configure failed"
	else
		econf || die "configure failed"
	fi

	emake || die "make failed"
}
src_install() {
	einstall
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
