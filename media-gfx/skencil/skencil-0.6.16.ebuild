# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/skencil/skencil-0.6.16.ebuild,v 1.9 2005/03/22 17:50:36 sekretarz Exp $

IUSE="nls"
DESCRIPTION="Interactive X11 vector drawing program"
SRC_URI="mirror://sourceforge/sketch/${P}.tar.gz"
HOMEPAGE="http://www.skencil.org/"
DEPEND=">=dev-python/imaging-1.1.2-r1
	dev-python/reportlab
	dev-lang/tk
	dev-python/pyxml"
RDEPEND="nls? ( sys-devel/gettext )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~amd64"

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
