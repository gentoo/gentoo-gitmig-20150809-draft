# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gd/ruby-gd-0.7.4.ebuild,v 1.4 2004/11/01 21:04:42 corsair Exp $

inherit ruby
USE_RUBY="ruby16 ruby18 ruby19"

MY_P="${P/gd/GD}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ruby-gd: an interface to Boutell GD library"
HOMEPAGE="http://tam.0xfa.com/ruby-gd/"
SRC_URI="http://tam.0xfa.com/ruby-gd/${MY_P}-1.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~ppc64"
IUSE="jpeg truetype"

DEPEND="virtual/ruby
	virtual/x11
	>=media-libs/gd-2.0
	jpeg? ( media-libs/jpeg )
	truetype? ( media-libs/freetype )"

src_compile() {
	local myconf=""
	myconf="${myconf} --enable-gd2_0 --with-xpm"

	if use jpeg; then
		myconf="${myconf} --with-jpeg"
	fi

	if use truetype; then
		myconf="${myconf} --with-ttf --with-freetype"
	fi

	ruby extconf.rb ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc Changes TODO readme.* doc/manual.rd doc/INSTALL.*
	dohtml doc/manual.html doc/manual_index.html
	insinto /usr/share/doc/${PF}/sample
	doins sample/*
}
