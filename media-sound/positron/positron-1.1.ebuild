# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/positron/positron-1.1.ebuild,v 1.10 2007/01/05 17:44:21 flameeyes Exp $

DESCRIPTION="Synchronization manager for the Neuros Audio Computer (www.neurosaudio.com) portable music player."
HOMEPAGE="http://www.xiph.org/positron"
SRC_URI="http://www.xiph.org/positron/files/source/${P}.tar.gz"

LICENSE="xiph"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="vorbis"

DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}
	 vorbis? ( dev-python/pyvorbis )"

src_install() {
	chmod +x setup.py
	./setup.py install --root "${D}" || die "installation failed"
}
