# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdchart/ruby-gdchart-0.0.9_beta.ebuild,v 1.6 2004/11/01 21:06:15 corsair Exp $

inherit ruby

MY_P="${P/_/-}"
DESCRIPTION="Ruby/GDChart is an extension to use Bruce Verderaime's GDCHART library (http://www.fred.net/brv/chart) from Ruby."
HOMEPAGE="http://sourceforge.jp/projects/ruby-gdchart/"
SRC_URI="mirror://sourceforge.jp/ruby-gdchart/1080/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 ~ppc ~ppc64"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"

DEPEND="virtual/ruby
	media-libs/gd"

S=${WORKDIR}/${MY_P}

src_compile() {

	ruby extconf.rb || die
	make || die
}

src_install () {
	DESTDIR=${D} emake install || die
	dodoc README.en ChangeLog bar_sample.rb pie_sample.rb
}
