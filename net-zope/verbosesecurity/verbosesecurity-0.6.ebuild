# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/verbosesecurity/verbosesecurity-0.6.ebuild,v 1.1 2005/01/13 20:56:11 radek Exp $

inherit zproduct eutils

DESCRIPTION="Zope Product which explains the reason for denied security access"
HOMEPAGE="http://hathawaymix.org/Software/VerboseSecurity"
SRC_URI="${HOMEPAGE}/VerboseSecurity-${PV}.tar.gz"
S="${WORKDIR}"
LICENSE="GPL-2"
KEYWORDS="~x86"
ZPROD_LIST="VerboseSecurity"
IUSE=""

RDEPEND=">=net-zope/zope-2.7.0
	${RDEPEND}"

pkg_preinst() {
	echo
	ewarn "This product does a 'monkey patch' to Zope."
	ewarn "One of the results being that zope will execute a little slower."
	echo
	ebeep 5
	epause 8
}
