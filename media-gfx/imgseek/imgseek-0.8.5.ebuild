# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imgseek/imgseek-0.8.5.ebuild,v 1.2 2005/07/22 20:47:45 dholm Exp $

inherit eutils

MY_P="imgSeek-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Photo collection manager with content-based search."
HOMEPAGE="http://imgseek.sourceforge.net/"
SRC_URI="mirror://sourceforge/imgseek/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2
	>=dev-python/PyQt-3.5
	dev-python/imaging"

src_compile() {
	python setup.py build || die "Python Build Failed"
}

src_install() {
	python setup.py install --prefix=${D}/usr || die "Python Install Failed"
	dodoc ChangeLog COPYING AUTHORS README THANKS
	insinto /usr/share/imgSeek
	doins imgSeek.png
	make_desktop_entry "imgSeek %F" imgSeek "/usr/share/imgSeek/imgSeek.png" "Graphics;Qt"
}
