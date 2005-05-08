# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libksnmp/libksnmp-0.3.ebuild,v 1.2 2005/05/08 09:43:39 greg_g Exp $

inherit kde

DESCRIPTION="KDE library to access SNMP statistics"
HOMEPAGE="http://dev.gentoo.org/~flameeyes/kdeapps.xhtml#libksnmp"
SRC_URI="http://digilander.libero.it/dgp85/files/${P}.tar.bz2"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-analyzer/net-snmp"

need-kde 3.1

src_compile() {
	kde_src_compile

#	if use doc; then
#		cd ${S}/doc
#		doxygen
#	fi
}

src_install() {
	kde_src_install

#	if use doc; then
#		dohtml -r ${S}/doc/html
#	fi
}
