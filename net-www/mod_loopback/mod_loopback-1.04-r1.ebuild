# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_loopback/mod_loopback-1.04-r1.ebuild,v 1.1 2005/01/09 10:25:57 hollow Exp $

inherit apache-module

DESCRIPTION="A web client debugging tool (DSO) for Apache2"
HOMEPAGE="http://www.snert.com/Software/mod_loopback/index.shtml"

S=${WORKDIR}/${PN}-1.4
SRC_URI="http://www.snert.com/Software/download/${PN}104.tgz"
DEPEND="=net-www/apache-1*"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE=""
SLOT="1"

APACHE1_MOD_CONF="${PVR}/28_mod_loopback"
APACHE1_MOD_DEFINE="LOOPBACK"

DOCFILES="CHANGES.txt LICENSE.txt"

need_apache1
