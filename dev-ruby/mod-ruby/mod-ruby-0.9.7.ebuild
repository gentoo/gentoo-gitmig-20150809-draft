# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod-ruby/mod-ruby-0.9.7.ebuild,v 1.8 2003/09/08 02:19:31 msterret Exp $

S=${WORKDIR}/mod_ruby-${PV}
DESCRIPTION="A Ruby Module for Apache"
SRC_URI="http://www.modruby.net/archive/mod_ruby-${PV}.tar.gz"
HOMEPAGE="http://www.modruby.net"
LICENSE="GPL-2 | LGPL-2.1"
KEYWORDS="x86"
SLOT="0"

DEPEND="=net-www/apache-1* >=dev-lang/ruby-1.6.1"

src_compile() {
	ruby ./configure.rb --with-apxs=/usr/sbin/apxs || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README.en README.ja ChangeLog COPYING
}

pkg_postinst() {
	einfo "Run ebuild ruby-${PV}.ebuild config to update httpd.conf"
}

pkg_config() {
        if [ -f "${ROOT}/etc/httpd/httpd.conf" ] ; then
                einfo "Activating ruby interpretation for /ruby location"
                cp ${ROOT}/etc/httpd/httpd.conf ${ROOT}/etc/httpd/httpd.conf.orig
		echo "
<IfDefine RUBY>
LoadModule ruby_module	      /usr/lib/apache/mod_ruby.so
</IfDefine>

<IfDefine RUBY>
AddModule mod_ruby.c
</IfDefine>

<IfModule mod_ruby.c>
RubyRequire apache/ruby-run

# Excucute files under /ruby as Ruby scripts
<Location /ruby>
	SetHandler ruby-object
	RubyHandler Apache::RubyRun.instance
</Location>

# Execute *.rbx files as Ruby scripts
<Files *.rbx>
	SetHandler ruby-object
	RubyHandler Apache::RubyRun.instance
</Files>
</IfModule>" >> ${ROOT}/etc/httpd/httpd.conf
		einfo "Add -DRUBY to HTTPD_OPTS in ${ROOT}/etc/conf.d/httpd to activate mod_ruby"
	fi
}
