# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xmms-controller/xfce4-xmms-controller-1.4.3.ebuild,v 1.3 2004/04/05 01:48:53 bcowan Exp $

IUSE=""
MY_P="${PN}-plugin-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Xfce panel xmms controller"
HOMEPAGE="http://eoin.angrystickman.com/"
SRC_URI="http://eoin.angrystickman.com/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64"

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
	    --datadir=/usr/share/xfce4-xmms-controller
	emake
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL COPYING README
}
