# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imgseek/imgseek-0.8.4.ebuild,v 1.1 2005/02/22 21:05:17 carlo Exp $

inherit eutils

MY_P="imgSeek-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Photo collection manager with content-based search."
HOMEPAGE="http://imgseek.sourceforge.net/"
SRC_URI="mirror://sourceforge/imgseek/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.2
	>=dev-python/PyQt-3.5
	dev-python/imaging"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${MY_P}-sizetype.patch
}

src_compile() {

	python setup.py build || die "Python Build Failed"

}

src_install() {

	python setup.py install --prefix=${D}/usr || die "Python Install Failed"

	dodoc ChangeLog COPYING AUTHORS README THANKS
}
