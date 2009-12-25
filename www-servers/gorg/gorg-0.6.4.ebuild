# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gorg/gorg-0.6.4.ebuild,v 1.2 2009/12/25 14:14:13 graaff Exp $

EAPI=2

inherit ruby eutils

DESCRIPTION="Back-end XSLT processor for an XML-based web site"
HOMEPAGE="http://gentoo.neysx.org/mystuff/gorg/gorg.xml"
SRC_URI="http://gentoo.neysx.org/mystuff/gorg/${P}.tgz"
IUSE="apache2 fastcgi mysql"

SLOT="0"
USE_RUBY="ruby18"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="
	>=dev-libs/libxml2-2.6.16
	>=dev-libs/libxslt-1.1.12"
RDEPEND="${DEPEND}
	mysql? ( >=dev-ruby/ruby-dbi-0.0.21[mysql] )
	apache2? ( www-servers/apache
		fastcgi? ( www-apache/mod_fcgid ) )
	fastcgi? ( >=dev-ruby/ruby-fcgi-0.8.5-r1 )"

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
