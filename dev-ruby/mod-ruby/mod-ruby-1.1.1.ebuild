# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod-ruby/mod-ruby-1.1.1.ebuild,v 1.1 2003/05/10 13:17:52 twp Exp $

MY_P=mod_ruby-${PV}
DESCRIPTION="Embeds the Ruby interpreter into Apache"
HOMEPAGE="http://modruby.net/"
SRC_URI="http://modruby.net/archive/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="apache2"
DEPEND=">=net-www/apache-1.3.3 >=dev-lang/ruby-1.6.4"
S=${WORKDIR}/${MY_P}

src_compile() {

	if [ "`use apache2`" ]; then
		:;
	else
		ewarn "apache support is UNTESTED"
	fi

	local two
	[ "`use apache2`" ] && two="2" || two=""

	./configure.rb --with-apxs=/usr/sbin/apxs${two}
	
	cp Makefile Makefile.orig
	sed -e "s:\(^APACHE_LIBEXECDIR = \$(DESTDIR)/usr/lib/apache${two}\):\1-extramodules:" \
		Makefile.orig > Makefile

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	if [ "`use apache2`" ]; then
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/20_mod_ruby.conf
	else
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/mod_ruby.conf
	fi

	dodoc ChangeLog COPYING README.* 

}

pkg_postinst() {
	if [ "`use apache2`" ]; then
		einfo "To enable mod_ruby, edit /etc/conf.d/apache2 and add \"-D RUBY\""
		einfo "You may also wish to edit /etc/conf.d/apache2/modules.d/20_mod_ruby.conf"
	else
		einfo "To enable mod_ruby:"
		einfo "1. Run \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
		einfo "2. Edit /etc/conf.d/apache and add \"-D RUBY\""
	fi
	einfo "You must restart apache for changes to take effect"
}

pkg_config() {
	if [ "`use apache2`" ]; then
		:;
	else
		${ROOT}/usr/sbin/apacheaddmod \
			${ROOT}/etc/apacheconf/conf/apache.conf \
			extramodules/mod_ruby.so mod_ruby.c ruby_module \
			before=perl define=RUBY addconf=conf/addon-modules/mod_ruby.conf
	fi
}
