# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-rhythmbox/gaim-rhythmbox-0.81.3.ebuild,v 1.1 2004/08/09 12:18:28 rizzo Exp $

inherit debug

DESCRIPTION="The Gaim-Rhythmbox plugin will automatically update your Gaim profile with the currently playing music in Rhythmbox."
HOMEPAGE="http://jon.oberheide.org/projects/gaim-rhythmbox/"
SRC_URI="http://jon.oberheide.org/projects/${PN}/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="~net-im/gaim-0.81
		media-sound/rhythmbox"
#RDEPEND=""

#S=${WORKDIR}/${P}

#src_compile() {
	#econf || die
	#emake || die "emake failed"
#}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
