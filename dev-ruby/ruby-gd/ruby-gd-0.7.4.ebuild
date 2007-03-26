# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gd/ruby-gd-0.7.4.ebuild,v 1.13 2007/03/26 13:54:07 armin76 Exp $

inherit ruby
USE_RUBY="ruby16 ruby18 ruby19"

MY_P="${P/gd/GD}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ruby-gd: an interface to Boutell GD library"
HOMEPAGE="http://tam.0xfa.com/ruby-gd/"
SRC_URI="http://tam.0xfa.com/ruby-gd/${MY_P}-1.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="-ia64 ~ppc ppc64 ~x86"
IUSE="jpeg truetype X"

DEPEND="virtual/ruby
	>=media-libs/gd-2.0
	jpeg? ( media-libs/jpeg )
	truetype? ( media-libs/freetype )
	X? ( || ( x11-libs/libX11 <virtual/x11-7 ) )"

pkg_setup() {
	if ! built_with_use media-libs/gd png; then
		eerror "dev-ruby/ruby-gd requires media-libs/gd compiled with the"
		eerror "'png' USE flag enabled, or it won't build."
		eerror "Please emerge media-libs/gd again with the 'png' USE flag"
		eerror "enabled and then try again."
		die "Missing png useflag on media-libs/gd."
	fi
}

src_compile() {
	local myconf="${myconf} --enable-gd2_0 --with-xpm"

	if use X; then
		myconf="${myconf} --with-xpm"
	fi

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
	make DESTDIR="${D}" install || die

	dodoc Changes TODO readme.* doc/manual.rd doc/INSTALL.*
	dohtml doc/manual.html doc/manual_index.html
	insinto /usr/share/doc/${PF}/sample
	doins sample/*
}
