# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-liveice/xmms-liveice-1.0.0-r1.ebuild,v 1.1 2006/01/16 19:24:20 metalgod Exp $

inherit eutils

IUSE=""

inherit gnuconfig

MY_P=LiveIce-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Stream your XMMS playlist to Shout/Icecast server"
HOMEPAGE="http://star.arm.ac.uk/~spm/software/liveice.html"
SRC_URI="http://star.arm.ac.uk/~spm/software/liveice-xmms.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="media-sound/xmms" # there is no need for the icecast on the localhost
						  # see #81132

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}_gtk_fix.patch

	gnuconfig_update
}

src_compile() {
	econf || die
	make CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
}
