# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-1.3.0.ebuild,v 1.3 2004/03/25 08:40:09 kumba Exp $

MY_P="RMagick-${PV}"
DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://rmagick.rubyforge.org/"
SRC_URI="http://rubyforge.org/download.php/35/${MY_P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha hppa ~mips ppc sparc x86"
DEPEND=">=dev-lang/ruby-1.6.8
	>=media-gfx/imagemagick-5.5.1"
S=${WORKDIR}/${MY_P}

src_compile() {
	./configure || die
	ruby install.rb config --prefix=/usr --doc-dir=/usr/share/doc/${PF}/html || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr --doc-dir=${D}/usr/share/doc/${PF}/html || die
	ruby install.rb install || die
	dodoc ChangeLog README.*
}
