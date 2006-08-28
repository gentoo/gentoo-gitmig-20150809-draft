# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nimage/nimage-0.5.9.ebuild,v 1.1 2006/08/28 15:39:19 pclouds Exp $

DESCRIPTION="simple Ruby class for displaying 2-D Data as images on X11 display"
HOMEPAGE="http://www.ir.isas.ac.jp/~masa/ruby/index-e.html"
SRC_URI="http://rubyforge.org/frs/download.php/12235/narray-${PV}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/ruby
	>=dev-ruby/narray-0.3.1
	x11-libs/libX11"
S="${WORKDIR}/narray-${PV}/${PN}"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make exec_prefix=/usr DESTDIR=${D} install || die
	dodoc ../ChangeLog README.*
}
