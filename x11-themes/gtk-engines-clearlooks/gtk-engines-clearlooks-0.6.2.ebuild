# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-clearlooks/gtk-engines-clearlooks-0.6.2.ebuild,v 1.1 2006/07/16 15:59:19 nelchael Exp $

inherit eutils

MY_PN=${PN/gtk-engines-/}

DESCRIPTION="Clearlooks theme for GTK+ 2"
HOMEPAGE="http://clearlooks.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {

	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS CREDITS NEWS README TODO ChangeLog

}
