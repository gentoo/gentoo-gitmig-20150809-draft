# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imgseek/imgseek-0.8.2.ebuild,v 1.2 2004/03/14 21:17:54 avenj Exp $

S=${WORKDIR}/imgSeek-${PV}
DESCRIPTION="Photo collection manager with content-based search."
HOMEPAGE="http://imgseek.sourceforge.net/"
SRC_URI="mirror://sourceforge/imgseek/imgSeek-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="qt"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/PyQt-3.5
	dev-python/Imaging"

src_compile() {

	python setup.py build || die "Python Build Failed"

}

src_install() {

	python setup.py install --prefix=${D}/usr || die "Python Install Failed"

	dodoc ChangeLog COPYING AUTHORS README THANKS
}
