# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gorg/gorg-0.6.3-r1.ebuild,v 1.4 2007/09/05 01:29:25 nichoj Exp $

inherit ruby eutils

DESCRIPTION="Back-end XSLT processor for an XML-based web site"
HOMEPAGE="http://gentoo.neysx.org/mystuff/gorg/gorg.xml"
SRC_URI="http://gentoo.neysx.org/mystuff/gorg/${P}.tgz"
IUSE="mysql"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/ruby
	>=dev-libs/libxml2-2.6.16
	>=dev-libs/libxslt-1.1.12"
RDEPEND="${DEPEND}
	mysql? ( >=dev-ruby/ruby-dbi-0.0.21 >=dev-ruby/mysql-ruby-2.5 )"

pkg_setup() {
	if use mysql && ! built_with_use dev-ruby/ruby-dbi mysql ; then
		eerror "You must compile ruby-dbi with the mysql USE flag enabled"
		die
	fi
	enewgroup gorg
	enewuser  gorg -1 -1 -1 gorg
}

src_compile() {
	# Fix listen issue w/ webrick
	sed -i -e 's/WEBrick::HTTPServer.new(/WEBrick::HTTPServer.new( :BindAddress=>"127.0.0.1",/' lib/gorg/www.rb

	ruby_src_compile
}

src_install() {
	ruby_einstall

	# install doesn't seem to chmod these correctly, forcing it here
	SITE_LIB_DIR=`$RUBY -r rbconfig -e 'puts Config::CONFIG["sitelibdir"]'`
	chmod +x ${D}/${SITE_LIB_DIR}/gorg/cgi-bin/*.cgi
	chmod +x ${D}/${SITE_LIB_DIR}/gorg/fcgi-bin/*.fcgi

	keepdir /etc/gorg; insinto /etc/gorg ; doins etc/gorg/*
	diropts -m0770 -o gorg -g gorg; keepdir /var/cache/gorg

	dodoc Changelog README
}

pkg_postinst() {
	elog "To use with apache, do:"
	elog "\t emerge www-servers/apache"
	elog "To use with fastcgi, do:"
	elog "\t emerge >=www-apache/mod_fcgid-1.05 >=dev-ruby/ruby-fcgi-0.8.5-r1"
}
