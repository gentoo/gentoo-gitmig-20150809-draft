# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod_ruby/mod_ruby-1.0.7.ebuild,v 1.2 2005/03/23 16:39:06 caleb Exp $

DESCRIPTION="An Apache2 DSO providing an embedded Ruby interpreter"
HOMEPAGE="http://www.modruby.net/"

SRC_URI="http://www.modruby.net/archive/${P}.tar.gz"
DEPEND="virtual/ruby
	=net-www/apache-2*"
LICENSE="BSD"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_compile() {
	./configure.rb --with-apxs=/usr/sbin/apxs2 || die "configure.rb failed"
	sed -i -e 's|usr/lib/apache2/modules|usr/lib/apache2-extramodules|' Makefile \
		|| die "sed failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/20_mod_ruby.conf || die
	dodoc ${FILESDIR}/20_mod_ruby.conf || die
	dodoc ChangeLog COPYING README* || die
}
