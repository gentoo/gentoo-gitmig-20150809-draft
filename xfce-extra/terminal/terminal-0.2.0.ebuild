# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/terminal/terminal-0.2.0.ebuild,v 1.1 2004/12/02 18:21:29 bcowan Exp $

MY_P="${PN/t/T}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Terminal with close ties to xfce"
HOMEPAGE="http://www.os-cillation.com/"
SRC_URI="http://download.berlios.de/xfce-goodies/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4*
	dev-libs/libxml2
	>=xfce-extra/exo-0.2.0
	>=x11-libs/vte-0.11.11
	x11-libs/startup-notification
	xfce-base/xfce4-base"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
src_compile() {
	econf #\
	    #--enable-debug=yes
	emake
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL README COPYING ChangeLog HACKING NEWS THANKS TODO
}
