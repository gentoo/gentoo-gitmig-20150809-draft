# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rudl/rudl-0.8.ebuild,v 1.2 2006/03/30 03:57:28 agriffis Exp $

inherit ruby eutils

DESCRIPTION="Rubyesque Directmedia Layer - Ruby/SDL bindings"
HOMEPAGE="http://rudl.sourceforge.net/"
SRC_URI="mirror://sourceforge/rudl/${P}-source.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"
KEYWORDS="~ia64 ~ppc ~x86"
IUSE=""
DEPEND=">=media-libs/libsdl-1.2.4.20020601
	>=media-libs/sdl-gfx-2.0.3
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-ttf-2.0.5
	virtual/ruby"

src_unpack() {
	unpack ${A}
}

src_compile() {
	ruby extconf.rb
	emake || die
}
