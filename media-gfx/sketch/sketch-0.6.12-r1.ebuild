# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sketch/sketch-0.6.12-r1.ebuild,v 1.5 2002/09/16 16:55:57 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="interactive X11 vector drawing program"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sketch.sourceforge.net/"

DEPEND=">=dev-python/Imaging-1.1.2-r1
	dev-lang/tk"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# patch setup to find more recent tcl/tk
	# note that if this doesn't find a dynamic lib, sketch may fail to run with
	# a X symbol error when loading paxtkinter
	t=setup.py
	cp $t $t.orig
	sed 's/for version in \[/for version in ["8.4",/' $t.orig > $t
}

src_compile() {
	use nls && useopts="${useopts} --with-nls"
	./setup.py configure ${useopts} || die "setup.py configure failed"
	./setup.py build || die "setup.py build failed"
}

src_install () {
	./setup.py install --prefix=/usr --dest-dir=${D}
	assert "setup.py install failed"

	# docs
	newdoc Pax/README README.pax
	newdoc Pax/COPYING COPYING.pax
	newdoc Filter/COPYING COPYING.filter
	newdoc Filter/README README.filter
	dodoc Examples Doc Misc
	dodoc README INSTALL BUGS CREDITS COPYING TODO PROJECTS FAQ NEWS
}
