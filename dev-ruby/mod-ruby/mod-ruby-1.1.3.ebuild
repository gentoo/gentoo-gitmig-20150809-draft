# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod-ruby/mod-ruby-1.1.3.ebuild,v 1.1 2004/04/10 12:19:52 usata Exp $

MY_P=mod_ruby-${PV}
DESCRIPTION="Embeds the Ruby interpreter into Apache"
HOMEPAGE="http://modruby.net/"
SRC_URI="http://modruby.net/archive/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
# 1.0.X -> stable branch; 1.1.Y -> development branch
KEYWORDS="~alpha ~sparc ~x86"
IUSE="apache2 doc"
DEPEND=">=net-www/apache-1.3.3
	virtual/ruby
	doc? ( dev-ruby/rdtool )"
S=${WORKDIR}/${MY_P}

apache2-detect() {
	if [ "`has_version '=net-www/apache-1*'`" != 1 -o "`use apache2`" ]; then
		true
	else
		false
	fi
}

src_compile() {

	local two
	if apache2-detect ; then
		two="2"
	else	# apache1
		ewarn "apache 1.3.x support is UNTESTED"
		two=""
	fi

	./configure.rb --with-apxs=/usr/sbin/apxs${two}

	sed -i -e "s:\(^APACHE_LIBEXECDIR = \$(DESTDIR)/usr/lib/apache${two}\)/modules:\1-extramodules:" Makefile

	emake || die

	if [ "`use doc`" ]; then
		cd doc
		emake
	fi
}

src_install() {

	make DESTDIR=${D} install || die

	if apache2-detect ; then
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/20_mod_ruby.conf
	else	# apache1
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/mod_ruby.conf
	fi

	dodoc ChangeLog COPYING README.*

	if [ "`use doc`" ]; then
		dohtml doc/*.css doc/*.html
	fi

}

pkg_postinst() {
	if apache2-detect ; then
		einfo "To enable mod_ruby, edit /etc/conf.d/apache2 and add \"-D RUBY\""
		einfo "You may also wish to edit /etc/conf.d/apache2/modules.d/20_mod_ruby.conf"
	else	# apache1
		einfo "To enable mod_ruby:"
		einfo "1. Run \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
		einfo "2. Edit /etc/conf.d/apache and add \"-D RUBY\""
	fi
	einfo "You must restart apache for changes to take effect"
}

pkg_config() {
	if ! apache2-detect ; then
		${ROOT}/usr/sbin/apacheaddmod \
			${ROOT}/etc/apache/conf/apache.conf \
			extramodules/mod_ruby.so mod_ruby.c ruby_module \
			before=perl define=RUBY addconf=conf/addon-modules/mod_ruby.conf
	fi
}
