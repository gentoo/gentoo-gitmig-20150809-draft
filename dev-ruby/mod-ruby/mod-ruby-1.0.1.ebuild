# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod-ruby/mod-ruby-1.0.1.ebuild,v 1.2 2003/02/13 11:40:30 vapier Exp $

DESCRIPTION="An Apache2 DSO providing an embedded Tcl interpreter"
HOMEPAGE="http://www.modruby.net/"

S=${WORKDIR}/mod_ruby-${PV}
SRC_URI="http://www.modruby.net/archive/mod_ruby-${PV}.tar.gz"
DEPEND="dev-lang/ruby =net-www/apache-2*"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

src_compile() {
	./configure.rb --with-apxs=/usr/sbin/apxs2 || die
	emake || die
}

src_install() {
	cp Makefile 1
	sed -e 's|usr/lib/apache2|usr/lib/apache2-extramodules|' 1 > Makefile
	make DESTDIR=${D} install || die
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/20_mod_ruby.conf
	dodoc ${FILESDIR}/20_mod_ruby.conf
	dodoc ChangeLog COPYING README*
}
