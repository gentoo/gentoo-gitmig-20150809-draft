# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ltsp-sound/ltsp-sound-3.0.1-r1.ebuild,v 1.4 2004/02/27 15:17:57 lanius Exp $

IUSE="gnome"
S=${WORKDIR}/ltsp_sound
HOMEPAGE="http://www.ltsp.org"
DESCRIPTION="Sound package for Linux Terminal Server"
SRC_URI="mirror://sourceforge/ltsp/ltsp_sound-${PV}-i386.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="=net-misc/ltsp-core-3.0*
		media-libs/libaudiooss
		media-libs/nas
		gnome? ( media-sound/esound )"

src_install() {
	cd ${S}
	# install client stuff
	# since we arent compiling might as well install it all
	# no need to nit pick
	insinto /opt/ltsp
	cp -r i386 ${D}/opt/ltsp

	dodoc README COPYING

}
