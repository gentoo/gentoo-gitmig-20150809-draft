# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyaudio/pyaudio-0.2.3.ebuild,v 1.1 2009/01/21 21:17:24 hncaldwell Exp $

DESCRIPTION="Python bindings for PortAudio"
HOMEPAGE="http://people.csail.mit.edu/hubert/pyaudio/"
SRC_URI="http://people.csail.mit.edu/hubert/pyaudio/packages/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python
	media-libs/portaudio"
RDEPEND="${DEPEND}"

src_install() {
	python setup.py install --root="${D}" || die
}
