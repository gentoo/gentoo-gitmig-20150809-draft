# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xmms-controller/xfce4-xmms-controller-1.4.3-r1.ebuild,v 1.1 2005/01/07 17:28:16 bcowan Exp $

DESCRIPTION="Xfce panel xmms controller"
HOMEPAGE="http://eoin.angrystickman.com/"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~sparc ~ppc ~x86"

PLUGIN=1
XFCE_CONFIG="--datadir=/usr/share/xfce4-xmms-controller"

inherit xfce4

SRC_URI="http://eoin.angrystickman.com/files/${MY_P}.tar.gz"

src_unpack() {
	unpack ${A}
	cd ${S}
	einfo "patching sources"
	sed -i "s:/usr/local/:/usr/:" config.h.in
	sed -i "s:share/:share/${PN}/:" panel-plugin/xfcexmms.c
}