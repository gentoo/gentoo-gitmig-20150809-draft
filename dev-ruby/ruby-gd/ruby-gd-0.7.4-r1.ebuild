# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gd/ruby-gd-0.7.4-r1.ebuild,v 1.8 2009/12/20 14:13:53 graaff Exp $

EAPI="2"

inherit ruby
USE_RUBY="ruby18"

MY_P="${P/gd/GD}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ruby-gd: an interface to Boutell GD library"
HOMEPAGE="http://tam.0xfa.com/ruby-gd/"
SRC_URI="http://tam.0xfa.com/ruby-gd/${MY_P}-1.tar.gz"
PATCHES=( "${FILESDIR}/ruby-gd-0.7.4-fix-interlace.patch" )

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ppc64 x86"
IUSE="jpeg truetype X"

DEPEND="
	>=media-libs/gd-2.0[png]
	jpeg? ( media-libs/jpeg )
	truetype? ( media-libs/freetype )
	X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_configure() {
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
}

# don't use the one from ruby.eclass
src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc Changes TODO readme.* doc/manual.rd doc/INSTALL.* || die
	dohtml doc/manual.html doc/manual_index.html
	insinto /usr/share/doc/${PF}/sample
	doins sample/*
}
