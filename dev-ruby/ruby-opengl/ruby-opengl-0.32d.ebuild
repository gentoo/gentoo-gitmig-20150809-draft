# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-opengl/ruby-opengl-0.32d.ebuild,v 1.4 2004/10/03 14:39:13 usata Exp $

inherit ruby

DESCRIPTION="OpenGL / GLUT bindings for ruby"
HOMEPAGE="http://www2.giganet.net/~yoshi/"
SRC_URI="http://www2.giganet.net/~yoshi/rbogl-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 ppc alpha ~sparc"

IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="virtual/ruby
	virtual/opengl
	media-libs/glut"

S=${WORKDIR}/opengl-${PV}

src_compile() {
	ruby -i -pe 'sub "PLATFORM","RUBY_PLATFORM"' extconf.rb
	ruby extconf.rb || die
	emake -j1 -f Makefile.ogl || die
	emake -j1 -f Makefile.glut || die
}

src_install () {
	make -f Makefile.ogl DESTDIR=${D} install || die "install ogl failed"
	make -f Makefile.glut DESTDIR=${D} install || die "install glut failed"

	dodoc README.EUC ChangeLog

	insinto /usr/share/${PN}/sample
	doins sample/*.rb
}
