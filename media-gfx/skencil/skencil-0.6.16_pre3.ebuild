# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/skencil/skencil-0.6.16_pre3.ebuild,v 1.1 2003/12/11 21:00:36 hanno Exp $

IUSE="nls"
S=${WORKDIR}/${P/_/}
DESCRIPTION="Interactive X11 vector drawing program"
SRC_URI="http://sketch.sourceforge.net/files/src/sketch/${P/_/}.tar.gz"
HOMEPAGE="http://sketch.sourceforge.net/"
DEPEND=">=dev-python/Imaging-1.1.2-r1
	dev-lang/tk"
RDEPEND="nls? ( sys-devel/gettext )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_compile() {
	use nls && useopts="${useopts} --with-nls"
	./setup.py configure ${useopts} || die "setup.py configure failed"
	./setup.py build || die "setup.py build failed"
}

src_install () {
	./setup.py install --prefix=/usr --dest-dir=${D}
	assert "setup.py install failed"

	newdoc Pax/README README.pax
	newdoc Pax/COPYING COPYING.pax
	newdoc Filter/COPYING COPYING.filter
	newdoc Filter/README README.filter
	dodoc Examples Doc Misc
	dodoc README INSTALL BUGS CREDITS COPYING TODO PROJECTS FAQ NEWS
}
