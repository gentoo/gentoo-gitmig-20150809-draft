# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rip/rip-1.07.ebuild,v 1.3 2003/07/12 20:30:57 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A command-line based audio CD ripper and mp3 encoder"
SRC_URI="http://rip.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://rip.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND=""

RDEPEND="media-sound/cdparanoia
	sys-apps/eject
	dev-lang/perl
	>=dev-perl/CDDB_get-1.66
	>=dev-perl/MP3-Info-0.91"

src_compile() {
	#the thing itself is just a perl script
	#so we need an empty method here
	echo "nothing to be done"

}

src_install () {

	chmod 755 rip
	dobin rip || die

	# Install documentation.
	dodoc COPYING FAQ README
}
