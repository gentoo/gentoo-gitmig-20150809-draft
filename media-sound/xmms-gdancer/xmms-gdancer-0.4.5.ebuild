# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-gdancer/xmms-gdancer-0.4.5.ebuild,v 1.1 2002/06/28 16:48:55 lostlogic Exp $

S=${WORKDIR}/gdancer-${PV}
DESCRIPTION="Dancing character plugin for XMMS"
HOMEPAGE="http://figz.com/gdancer/"
SRC_URI="http://figz.com/gdancer/files/gdancer-${PV}.tar.gz"
SLOT="0"
LICENSE="GPL"

DEPEND="media-sound/xmms
	=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	
}

pkg_postinst () {

	einfo "${GOOD}**************************************************** *${NORMAL}"
	einfo "  Themes can be found at:                            ${GOOD}*${NORMAL}"
	einfo "     http://figz.com/gdancer/themes.php              ${GOOD}*${NORMAL}"
	einfo "${GOOD}**************************************************** *${NORMAL}"

}
