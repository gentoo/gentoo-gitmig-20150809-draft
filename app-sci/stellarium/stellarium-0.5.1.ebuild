# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/stellarium/stellarium-0.5.1.ebuild,v 1.1 2003/07/13 19:30:43 avenj Exp $

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://stellarium.free.fr/"
SRC_URI="http://stellarium.free.fr/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/opengl
	app-text/dos2unix"

S=${WORKDIR}/${P}

src_unpack() {
	# Configure script is in DOS format for some reason
	unpack ${A}
	cd ${S}
	dos2unix configure
	chmod 755 configure
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
