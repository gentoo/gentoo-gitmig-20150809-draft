# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdchart/ruby-gdchart-1.0.0.ebuild,v 1.1 2006/03/24 12:58:01 caleb Exp $

inherit ruby

MY_P="${P/_/-}"
DESCRIPTION="Ruby/GDChart is an extension to use Bruce Verderaime's GDCHART library (http://www.fred.net/brv/chart) from Ruby."
HOMEPAGE="http://sourceforge.jp/projects/ruby-gdchart/"
SRC_URI="http://rubyforge.org/frs/download.php/6883/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64"
IUSE=""
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
