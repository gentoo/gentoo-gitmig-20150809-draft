# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/goog-sitemapgen/goog-sitemapgen-1.4.ebuild,v 1.1 2007/06/23 06:39:53 jmglov Exp $

inherit distutils

# Upstream version is sitemap_gen
MY_PN="sitemap_gen"
MY_P="${MY_PN}-${PV}"

S="${WORKDIR}/${MY_P}"

KEYWORDS="~x86"
DESCRIPTION="Sitemap Gen is a python script which will generate an xml Sitemap for your web site."
HOMEPAGE="http://goog-sitemapgen.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/python-2.3"

src_unpack() {
	unpack ${A} && cd ${S}

	epatch ${FILESDIR}/${P}.patch

	mv sitemap_gen.py sitemap_gen
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install

	dodoc AUTHORS COPYING example_*
}
