# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gorg/gorg-0.5.ebuild,v 1.8 2007/09/05 01:29:25 nichoj Exp $

inherit ruby

DESCRIPTION="Back-end XSLT processor for an XML-based web site"
HOMEPAGE="http://dev.gentoo.org/~neysx/gorg/gorg.html"
SRC_URI="http://dev.gentoo.org/~neysx/gorg/${P}.tgz"
IUSE=""

SLOT="0"
USE_RUBY="ruby18"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"

DEPEND=">=dev-libs/libxml2-2.6.16
		>=dev-libs/libxslt-1.1.12"

src_install() {
	ruby_src_install
	keepdir /etc/gorg
	diropts -m0750 -o apache -g apache; dodir /var/cache/gorg
	insinto etc/gorg ; doins ${S}/etc/gorg/*
	dodoc Changelog
}

pkg_postinst() {
	elog "To use with apache, do:"
	elog "\t emerge www-servers/apache"
	elog "To use with fastcgi, do:"
	elog "\t emerge >=www-apache/mod_fcgid-1.05 >=dev-ruby/ruby-fcgi-0.8.5-r1"
}
