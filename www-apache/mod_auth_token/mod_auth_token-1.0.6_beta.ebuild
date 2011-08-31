# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $

EAPI=3

inherit apache-module eutils

MY_P="${PN}-${PV/_/-}"
DESCRIPTION="Token based URI access module for Apache2."
HOMEPAGE="http://code.google.com/p/mod-auth-token/"
SRC_URI="http://mod-auth-token.googlecode.com/files/${MY_P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="75_${PN}"
APACHE2_MOD_DEFINE="AUTH_TOKEN"

need_apache2_2

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ap_pstrcat.patch
}
