# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-6.0b-r1.ebuild,v 1.2 2002/12/09 04:33:20 manson Exp $

inherit nsplugins

IUSE=""
S=${WORKDIR}/flashplayer_installer
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="http://www.macromedia.com/software/flashplayer/special/beta/installers/linux/plugin/install_flash_player_6_linux.tar.gz"
HOMEPAGE="http://www.macromedia.com/"

DEPEND="virtual/glibc"
SLOT="0"
KEYWORDS="~x86 -ppc ~sparc "
LICENSE="Macromedia"

src_install() {                               
	exeinto /opt/netscape/plugins
	insinto /opt/netscape/plugins
	doexe libflashplayer.so
	doins flashplayer.xpt

	inst_plugin /opt/netscape/plugins/libflashplayer.so
	inst_plugin /opt/netscape/plugins/flashplayer.xpt
}
