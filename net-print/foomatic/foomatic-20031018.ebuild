# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic/foomatic-20031018.ebuild,v 1.2 2003/12/10 18:34:34 lanius Exp $

DESCRIPTION="The Foomatic printing meta package"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""

DEPEND="=net-print/foomatic-filters-20031018
	=net-print/foomatic-db-engine-20031018
	=net-print/foomatic-db-20031018"

pkg_postinst () {
	einfo
	einfo "If printing does not work, try to install the latest version of"
	einfo "gimp-print / hpijs or regerate your ppd file."
	einfo
}
