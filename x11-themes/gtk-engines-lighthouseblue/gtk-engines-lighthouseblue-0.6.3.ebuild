# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-lighthouseblue/gtk-engines-lighthouseblue-0.6.3.ebuild,v 1.1 2005/08/02 10:21:05 leonardop Exp $

MY_PN=lighthouseblue-gtk1
MY_P=${MY_PN}-${PV}
DESCRIPTION="LighthouseBlue GTK+ 1 theme engine"
HOMEPAGE="http://lighthouseblue.sourceforge.net/"
SRC_URI="mirror://sourceforge/lighthouseblue/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"

KEYWORDS="~x86 ~ppc ~amd64"
IUSE="static"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_PN}

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog README
}
