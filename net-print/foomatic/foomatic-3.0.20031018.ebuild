# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic/foomatic-3.0.20031018.ebuild,v 1.1 2003/12/31 12:50:04 lanius Exp $

DESCRIPTION="The Foomatic printing meta package"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""

DEPEND="=net-print/foomatic-filters-3.0.20031018
	=net-print/foomatic-db-engine-3.0.20031018
	net-print/foomatic-db"

pkg_postinst () {
	einfo
	einfo "If printing does not work, try to install the latest version of"
	einfo "gimp-print / hpijs or regerate your ppd file."
	einfo
}
