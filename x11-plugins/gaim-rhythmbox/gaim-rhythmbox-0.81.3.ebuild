# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-rhythmbox/gaim-rhythmbox-0.81.3.ebuild,v 1.6 2004/09/10 03:21:53 rizzo Exp $

inherit debug

DESCRIPTION="automatically update your Gaim profile with current info from Rhythmbox"
HOMEPAGE="http://gaim-rhythmbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""

DEPEND=">=net-im/gaim-0.81
	media-sound/rhythmbox"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
