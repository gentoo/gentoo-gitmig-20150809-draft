# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-0.71.ebuild,v 1.1 2003/04/19 12:34:48 seemant Exp $

IUSE=""

inherit nsplugins

S="${WORKDIR}/mplayerplug-in"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
DESCRIPTION="mplayer plug-in for Mozilla"
SRC_URI="mirror://sourceforge/${PN}/${PN}_v${PV}.tar.gz
	mirror://sourceforge/${PN}/mini.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=media-video/mplayer-0.90_rc4"

src_compile() {
	[ -z "${CC}" ] && CC="gcc"
	emake CC="${CC}" OPTIMIZER="${CFLAGS}" || die
}

src_install() {
	exeinto /opt/netscape/plugins
	doexe mplayerplug-in.so
	
	inst_plugin /opt/netscape/plugins/mplayerplug-in.so

	insinto /usr/share/mplayer/Skin/mini
	doins ${WORKDIR}/mini/*

	dodir /etc
	# For some reason this does not work yet for mplayer options, and
	# setting 'vo' cause it for 'mozilla file:///space/movies/foo.avi'
	# at least to not work...
	cat > ${D}/etc/mplayerplug-in.conf <<END
# Should it handle embedded movies ?
noembed=0

# Set to 'mini' if you want the seek bar
use-gui=no

# Normal mplayer style config options
#vo=x11
fs=no
zoom=yes
END

	dodoc TODO ChangeLog INSTALL README
}
