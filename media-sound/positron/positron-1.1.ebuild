# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/positron/positron-1.1.ebuild,v 1.6 2004/07/13 07:49:29 eradicator Exp $

DESCRIPTION="Synchronization manager for the Neuros Audio Computer (www.neurosaudio.com) portable music player."
HOMEPAGE="http://www.xiph.org/positron"
SRC_URI="http://www.xiph.org/positron/files/source/${P}.tar.gz"
LICENSE="xiph"
SLOT="0"

# ~sparc and ~amd64: 1.1: Compiles fine and should work, but I lack the hardware
# to test thuroughly.  If you use positron on one of these archs, please email
# me so I know it works -- eradicator

KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE="oggvorbis"
DEPEND=">=dev-lang/python-2.2"

RDEPEND="${DEPEND}
	 oggvorbis? ( dev-python/pyvorbis )"

src_compile() {
	einfo "No compilation required"
}

src_install() {
	chmod +x setup.py
	./setup.py install --root ${D} || die
}
