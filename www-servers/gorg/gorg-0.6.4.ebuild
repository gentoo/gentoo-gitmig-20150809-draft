# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gorg/gorg-0.6.4.ebuild,v 1.4 2011/04/09 18:13:34 graaff Exp $

EAPI=2

inherit ruby eutils

DESCRIPTION="Back-end XSLT processor for an XML-based web site"
HOMEPAGE="http://www.gentoo.org/proj/en/gdp/doc/gorg.xml"
SRC_URI="http://gentoo.neysx.org/mystuff/gorg/${P}.tgz"
IUSE="fastcgi mysql"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="
	>=dev-libs/libxml2-2.6.16
	>=dev-libs/libxslt-1.1.12"
RDEPEND="${DEPEND}
	mysql? ( >=dev-ruby/ruby-dbi-0.0.21[mysql] )
	fastcgi? (
		virtual/httpd-fastcgi
		>=dev-ruby/ruby-fcgi-0.8.5-r1
	)"

pkg_setup() {
	enewgroup gorg
	enewuser  gorg -1 -1 -1 gorg
}

src_install() {
	ruby_einstall

	# install doesn't seem to chmod these correctly, forcing it here
	SITE_LIB_DIR=`$RUBY -r rbconfig -e 'puts Config::CONFIG["sitelibdir"]'`
	chmod +x "${D}"/${SITE_LIB_DIR}/gorg/cgi-bin/*.cgi
	chmod +x "${D}"/${SITE_LIB_DIR}/gorg/fcgi-bin/*.fcgi

	keepdir /etc/gorg; insinto /etc/gorg ; doins etc/gorg/*
	diropts -m0770 -o gorg -g gorg; keepdir /var/cache/gorg

	dodoc Changelog README
}
