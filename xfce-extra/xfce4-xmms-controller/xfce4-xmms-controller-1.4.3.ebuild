# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xmms-controller/xfce4-xmms-controller-1.4.3.ebuild,v 1.7 2005/01/07 17:28:16 bcowan Exp $

MY_P="${PN}-plugin-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Xfce panel xmms controller"
HOMEPAGE="http://eoin.angrystickman.com/"
SRC_URI="http://eoin.angrystickman.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~sparc ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.6
	dev-libs/libxml2
	xfce-base/xfce4-base"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:/usr/local/:/usr/:" config.h.in
	sed -i "s:share/:share/${PN}/:" panel-plugin/xfcexmms.c
}

src_compile() {
	econf \
	    --datadir=/usr/share/xfce4-xmms-controller || die "econf failed"
	emake
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL README
}
