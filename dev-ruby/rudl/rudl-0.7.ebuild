# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rudl/rudl-0.7.ebuild,v 1.3 2003/07/12 13:03:10 aliz Exp $

DESCRIPTION="Rubyesque Directmedia Layer - Ruby/SDL bindings"
HOMEPAGE="http://froukepc.dhs.org/rudl/"
SRC_URI="http://froukepc.dhs.org/rudl/download/source/${P}-source.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=libsdl-1.2.4.20020601
	>=sdl-gfx-2.0.3
	>=sdl-image-1.2.2
	>=sdl-mixer-1.2.4
	>=sdl-ttf-2.0.5
	>=ruby-1.6.7"
S="${WORKDIR}/rudl"

src_compile() {
	cd ${S}
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
