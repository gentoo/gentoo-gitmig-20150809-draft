# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rudl/rudl-0.7.ebuild,v 1.5 2004/04/10 15:50:49 usata Exp $

inherit ruby eutils

DESCRIPTION="Rubyesque Directmedia Layer - Ruby/SDL bindings"
HOMEPAGE="http://rudl.sourceforge.net/"
SRC_URI="mirror://sourceforge/rudl/${P}-source.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
USE_RUBY="ruby16 ruby18 ruby19"
IUSE=""
DEPEND=">=media-libs/libsdl-1.2.4.20020601
	>=media-libs/sdl-gfx-2.0.3
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-ttf-2.0.5
	virtual/ruby"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-extconf-gentoo.diff
}

src_compile() {
	ruby extconf.rb
	emake || die
	#make || die
}

src_install() {
	# AFAIK this package's makefile does not make use of DESTDIR
	# and it contains neither man nor info pages.
	# make DESTDIR=${D} install || die
	make prefix=${D}/usr install || die
}
