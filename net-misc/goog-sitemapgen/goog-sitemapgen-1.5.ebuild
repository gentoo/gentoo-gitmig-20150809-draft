# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/goog-sitemapgen/goog-sitemapgen-1.5.ebuild,v 1.1 2012/03/20 10:49:38 pacho Exp $

EAPI=4
PYTHON_DEPEND="2"

inherit eutils distutils

# Upstream version is sitemap_gen
MY_PN="sitemap_gen"
MY_P="${MY_PN}_${PV}"

S="${WORKDIR}/"

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Sitemap Gen is a python script which will generate an xml Sitemap for your web site."
HOMEPAGE="http://goog-sitemapgen.sourceforge.net/"
SRC_URI="http://sitemap-generators.googlecode.com/files/${MY_P}.tar.gz"
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
	mv sitemap_gen.py sitemap_gen || die
}
