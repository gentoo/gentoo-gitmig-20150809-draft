# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-1.2.ebuild,v 1.1 2004/01/22 04:32:57 seemant Exp $

IUSE=""

inherit nsplugins

S=${WORKDIR}/${PN}
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
DESCRIPTION="mplayer plug-in for Mozilla"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/mini.tar.bz2"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ia64 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND=">=media-video/mplayer-1.0_pre2"

RESTRICT="nomirror"

src_compile() {

	econf || die

	[ -z "${CC}" ] && CC="gcc"
	emake || die
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

# Disable some video formats
#enable-real=0
#enable-qt=0
#enable-wm=0
#enable-mpeg=0
END

	dodoc TODO ChangeLog INSTALL README
}
