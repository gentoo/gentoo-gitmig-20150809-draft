# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libksnmp/libksnmp-0.3.ebuild,v 1.5 2007/07/13 07:18:13 mr_bones_ Exp $

inherit kde

DESCRIPTION="KDE library to access SNMP statistics"
HOMEPAGE="http://dev.gentoo.org/~flameeyes/kdeapps#libksnmp"
SRC_URI="http://digilander.libero.it/dgp85/files/${P}.tar.bz2"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-analyzer/net-snmp"

need-kde 3.1

PATCHES="${FILESDIR}/${P}-gcc41.patch"
