# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-1.2.0.ebuild,v 1.1 2003/05/13 12:28:50 twp Exp $

inherit eutils

MY_P="RMagick-${PV}"
DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://home.nc.rr.com/rmagick/"
SRC_URI="http://home.nc.rr.com/rmagick/${MY_P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha arm hppa mips ppc sparc x86"
DEPEND=">=dev-lang/ruby-1.6.8
	>=media-gfx/imagemagick-5.5.1"
S=${WORKDIR}/${MY_P}

src_compile() {
	./configure || die
	ruby install.rb config --prefix=/usr --doc-dir=/usr/share/doc/${PF} || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr --doc-dir=${D}/usr/share/doc/${PF} || die
	ruby install.rb install || die
}
