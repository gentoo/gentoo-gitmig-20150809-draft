# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/goog-sitemapgen/goog-sitemapgen-1.4.ebuild,v 1.6 2011/04/05 18:15:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit eutils distutils

# Upstream version is sitemap_gen
MY_PN="sitemap_gen"
MY_P="${MY_PN}-${PV}"

S="${WORKDIR}/${MY_P}"

KEYWORDS="amd64 x86"
DESCRIPTION="Sitemap Gen is a python script which will generate an xml Sitemap for your web site."
HOMEPAGE="http://goog-sitemapgen.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="AUTHORS example_*"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}"/${P}.patch

	mv sitemap_gen.py sitemap_gen
}
