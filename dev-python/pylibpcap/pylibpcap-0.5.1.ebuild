# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibpcap/pylibpcap-0.5.1.ebuild,v 1.3 2006/09/19 20:58:21 liquidx Exp $

inherit distutils eutils

DESCRIPTION="Python interface to libpcap"
HOMEPAGE="http://sourceforge.net/projects/${PN}/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND="virtual/python
	virtual/libpcap
	dev-lang/swig"

src_unpack() {
	unpack ${A}
	cd ${S}
	if $(has_version \>=dev-lang/swig-1.3.29); then
		epatch ${FILESDIR}/${PN}-swig-1.3.29.patch
	fi
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
