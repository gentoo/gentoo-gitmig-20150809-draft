# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-tfmx/xmms-tfmx-0.5.ebuild,v 1.3 2004/09/03 09:01:37 eradicator Exp $

IUSE=""

DESCRIPTION="Plugin to listen tfmx files on xmms"
HOMEPAGE="http://xmms-tfmx.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-tfmx/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
# amd64/sparc failed 0.5 -- eradicator
KEYWORDS="x86 -amd64 -sparc -ppc"
LICENSE="GPL-2"

DEPEND="media-sound/xmms"

src_compile () {
	econf --with-plugindir=`xmms-config --input-plugin-dir`|| die 'Configure failed'
	emake || die "Error compiling"
}

src_install()
{
	make DESTDIR="${D}" install || die
	dodoc README tfmxplay.txt tfmxplugreadme.txt
}
