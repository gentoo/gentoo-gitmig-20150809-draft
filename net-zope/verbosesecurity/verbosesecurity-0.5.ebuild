# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/verbosesecurity/verbosesecurity-0.5.ebuild,v 1.5 2006/01/27 02:49:08 vapier Exp $

inherit zproduct eutils

DESCRIPTION="Zope Product which explains the reason for denied security access"
HOMEPAGE="http://hathaway.freezope.org/Software/VerboseSecurity"
SRC_URI="http://hathaway.freezope.org/Software/VerboseSecurity/VerboseSecurity-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=net-zope/zope-2.6.0"

S=${WORKDIR}

ZPROD_LIST="VerboseSecurity"

pkg_preinst() {
	echo
	ewarn "This product does a 'monkey patch' to Zope."
	ewarn "One of the results being that zope will execute a little slower."
	echo
	ebeep 5
	epause 8
}
