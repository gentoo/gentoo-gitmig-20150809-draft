# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-rhythmbox/gaim-rhythmbox-0.81.3.ebuild,v 1.5 2004/09/02 18:22:39 pvdabeel Exp $

inherit debug

DESCRIPTION="automatically update your Gaim profile with current info from Rhythmbox"
HOMEPAGE="http://jon.oberheide.org/projects/gaim-rhythmbox/"
SRC_URI="http://jon.oberheide.org/projects/${PN}/downloads/${P}.tar.gz"

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
