# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/qt4-qtruby/qt4-qtruby-1.4.5.ebuild,v 1.2 2006/05/05 17:49:20 caleb Exp $

DESCRIPTION="Ruby bindings for QT4"
HOMEPAGE="http://rubyforge.org/projects/korundum"
SRC_URI="http://rubyforge.org/frs/download.php/9998/qt4-qtruby-1.4.5.tgz"

inherit toolchain-funcs

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=virtual/ruby-1.8
	=x11-libs/qt-4*"

SLOT="0"

src_compile() {
	myconf="--with-qt-dir=/usr --with-qt-libraries=/usr/$(get_libdir)/qt4 --with-qt-includes=/usr/include/qt4"
	myconf="${myconf} --with-threshold=5"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
