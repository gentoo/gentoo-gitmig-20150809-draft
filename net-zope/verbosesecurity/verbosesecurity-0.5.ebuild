# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/verbosesecurity/verbosesecurity-0.5.ebuild,v 1.3 2004/09/06 00:53:10 ciaranm Exp $

inherit zproduct eutils

DESCRIPTION="Zope Product which explains the reason for denied security access"
HOMEPAGE="http://hathaway.freezope.org/Software/VerboseSecurity"
SRC_URI="http://hathaway.freezope.org/Software/VerboseSecurity/VerboseSecurity-${PV}.tar.gz"
S="${WORKDIR}"
LICENSE="GPL-2"
KEYWORDS="~x86"
ZPROD_LIST="VerboseSecurity"

RDEPEND=">=net-zope/zope-2.6.0
	${RDEPEND}"

pkg_preinst() {
	echo
	ewarn "This product does a 'monkey patch' to Zope."
	ewarn "One of the results being that zope will execute a little slower."
	echo
	ebeep 5
	epause 8
}
