# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod-ruby/mod-ruby-1.0.7.ebuild,v 1.1 2004/04/10 12:19:52 usata Exp $

DESCRIPTION="An Apache2 DSO providing an embedded Tcl interpreter"
HOMEPAGE="http://www.modruby.net/"

S=${WORKDIR}/mod_ruby-${PV}
SRC_URI="http://www.modruby.net/archive/mod_ruby-${PV}.tar.gz"
DEPEND="virtual/ruby
	=net-www/apache-2*"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

src_compile() {
	./configure.rb --with-apxs=/usr/sbin/apxs2 || die
	sed -i -e 's|usr/lib/apache2/modules|usr/lib/apache2-extramodules|' Makefile
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/20_mod_ruby.conf
	dodoc ${FILESDIR}/20_mod_ruby.conf
	dodoc ChangeLog COPYING README*
}
