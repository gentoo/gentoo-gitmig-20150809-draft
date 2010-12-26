# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/issuetrackerproduct/issuetrackerproduct-0.11.0.ebuild,v 1.1 2010/12/26 20:23:27 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit python

MY_PN="IssueTrackerProduct"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A user-friendly issue tracker web application for Zope"
HOMEPAGE="http://www.issuetrackerproduct.com/"
SRC_URI="http://www.issuetrackerproduct.com/Download/${MY_P}.tgz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/simplejson
	dev-python/stripogram
	net-zope/accesscontrol
	net-zope/acquisition
	net-zope/datetime
	net-zope/persistence
	net-zope/zexceptions
	net-zope/zlog
	net-zope/zodb
	>=net-zope/zope-2.12
	net-zope/zope-contenttype
	net-zope/zope-structuredtext"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_install() {
	installation() {
		insinto $(python_get_sitedir)/Products/${MY_PN}
		doins -r *
	}
	python_execute_function installation

	dodoc CHANGES.txt README.txt TODO.txt || die "dodoc failed"
}

pkg_postinst() {
	python_mod_optimize -x /www/ Products/${MY_PN}
}

pkg_postrm() {
	python_mod_cleanup Products/${MY_PN}
}
