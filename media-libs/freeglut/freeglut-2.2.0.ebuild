# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freeglut/freeglut-2.2.0.ebuild,v 1.9 2004/11/03 15:41:56 corsair Exp $

DESCRIPTION="A completely OpenSourced alternative to the OpenGL Utility Toolkit (GLUT) library"
HOMEPAGE="http://freeglut.sourceforge.net/"
SRC_URI="mirror://sourceforge/freeglut/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86 ~alpha ~ppc64"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	!virtual/glut"
PROVIDE="virtual/glut"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	docinto doc
	dohtml -r doc/*.html doc/*.png
}
