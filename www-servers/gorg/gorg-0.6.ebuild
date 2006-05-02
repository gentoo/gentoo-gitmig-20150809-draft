# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gorg/gorg-0.6.ebuild,v 1.2 2006/05/02 22:07:24 swegener Exp $

inherit ruby

DESCRIPTION="Back-end XSLT processor for an XML-based web site"
HOMEPAGE="http://gentoo.neysx.org/mystuff/gorg/gorg.xml"
SRC_URI="http://gentoo.neysx.org/mystuff/gorg/${P}.tgz"
IUSE="apache fastcgi mysql"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

DEPEND=">=dev-libs/libxml2-2.6.16
		>=dev-libs/libxslt-1.1.12"
RDEPEND="apache? ( net-www/apache )
		 fastcgi? ( >=www-apache/mod_fcgid-1.05
					>=dev-ruby/ruby-fcgi-0.8.5-r1 )
		 mysql?	  (	>=dev-db/mysql-4
					>=dev-ruby/ruby-dbi-0.0.21
					>=dev-ruby/mysql-ruby-2.5 )"

src_install() {
	ruby_src_install
	keepdir /etc/gorg
	diropts -m0750 -o apache -g apache; dodir /var/cache/gorg
	keepdir /var/cache/gorg
	insinto etc/gorg ; doins ${S}/etc/gorg/*
	dodoc Changelog
}
