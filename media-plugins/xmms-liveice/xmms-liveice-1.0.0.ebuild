# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-liveice/xmms-liveice-1.0.0.ebuild,v 1.7 2004/07/14 20:43:37 agriffis Exp $

IUSE=""

inherit gnuconfig

MY_P=LiveIce-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Stream your XMMS playlist to Shout/Icecast server"
HOMEPAGE="http://star.arm.ac.uk/~spm/software/liveice.html"
SRC_URI="http://star.arm.ac.uk/~spm/software/liveice-xmms.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="net-misc/icecast
	media-sound/xmms"

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_compile() {
	econf || die
	make CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
}
