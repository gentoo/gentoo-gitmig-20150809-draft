# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdchart/ruby-gdchart-1.0.0.ebuild,v 1.4 2007/07/02 15:06:41 peper Exp $

RUBY_BUG_145222=yes
inherit ruby

MY_P="${P/_/-}"
DESCRIPTION="Ruby/GDChart is an extension to use Bruce Verderaime's GDCHART library (http://www.fred.net/brv/chart) from Ruby."
HOMEPAGE="http://sourceforge.jp/projects/ruby-gdchart/"
SRC_URI="http://rubyforge.org/frs/download.php/6952/${MY_P}.tar.gz"

RESTRICT="mirror"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64"
IUSE="examples"
USE_RUBY="ruby18 ruby19"

DEPEND="virtual/ruby
	media-libs/gd"

S=${WORKDIR}/${MY_P}

src_compile() {
	cd ext
	ruby extconf.rb || die
	make || die
}

src_install () {
	cd ext
	make DESTDIR=${D} install || die
	dodoc README.en ChangeLog bar_sample.rb pie_sample.rb
}
