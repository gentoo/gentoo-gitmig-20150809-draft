# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fxruby/fxruby-1.0.17.ebuild,v 1.2 2003/02/13 11:40:22 vapier Exp $

S=${WORKDIR}/FXRuby-${PV}
DESCRIPTION="FXRuby is the Ruby language binding to the FOX GUI toolkit."
SRC_URI="mirror://sourceforge/fxruby/FXRuby-${PV}.tar.gz"
HOMEPAGE="http://www.fxruby.org"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.6
	>=x11-libs/fox-1.0.17"

src_compile() {
	ruby install.rb config --prefix=${D}/usr || die "Failed to configure FXRuby"
	ruby install.rb setup || die "Failed to setup FXRuby"
}

src_install() {
	ruby install.rb install || die "Failed to install FXRuby"

	dodoc [A-Z]*
	cp -dr examples doc ${D}/usr/share/doc/${PF}
}
