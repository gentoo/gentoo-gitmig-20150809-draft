# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/efxmms/efxmms-0.0.3.ebuild,v 1.9 2004/07/14 20:40:10 agriffis Exp $

IUSE=""

inherit gnuconfig

MY_P=${PN/efx/EFX}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Provides the possibility to send the audio through a queue of multiple effect plugins instead of one effect that XMMS originally handles"
HOMEPAGE="http://sourceforge.net/projects/efxmms"
SRC_URI="mirror://sourceforge/efxmms/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~sparc"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install() {
	einstall \
		libdir=${D}/usr/lib/xmms/Effect || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README  README.EFX TODO
}
