# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-opengl/ruby-opengl-0.32c.ebuild,v 1.1 2004/02/21 10:43:10 usata Exp $

inherit ruby

DESCRIPTION="OpenGL / GLUT bindings for ruby"
HOMEPAGE="http://www2.giganet.net/~yoshi/"
SRC_URI="http://www2.giganet.net/~yoshi/rbogl-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
USE_RUBY="ruby16 ruby18"
DEPEND=">=dev-lang/ruby-1.6"

S=${WORKDIR}/opengl-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-extconf-gentoo.diff
	epatch ${FILESDIR}/${P}-font-gentoo.diff
}

src_compile() {
	ruby extconf.rb || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README.EUC ChangeLog

	insinto /usr/share/${PN}/sample
	doins sample/*.rb
}
