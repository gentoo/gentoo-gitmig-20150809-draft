# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-1.1.0.ebuild,v 1.1 2003/04/08 10:06:30 twp Exp $

MY_P="RMagick-${PV}"
DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://home.nc.rr.com/rmagick/"
SRC_URI="http://home.nc.rr.com/rmagick/${MY_P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
DEPEND=">=dev-lang/ruby-1.6.8
	>=media-gfx/imagemagick-5.5.1"
S=${WORKDIR}/${MY_P}

src_compile() {
	./configure || die
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	RUBYLIB=`ruby -r rbconfig -e "print ['sitelibdir', 'sitearchdir'].collect { |s| '${D}' + Config::CONFIG[s] }.join(':')"`
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die
}
