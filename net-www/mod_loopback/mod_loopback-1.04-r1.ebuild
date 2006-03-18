# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_loopback/mod_loopback-1.04-r1.ebuild,v 1.3 2006/03/18 12:22:39 kloeri Exp $

inherit apache-module

DESCRIPTION="A web client debugging tool (DSO) for Apache"
HOMEPAGE="http://www.snert.com/Software/mod_loopback/index.shtml"

S=${WORKDIR}/${PN}-1.4
SRC_URI="http://www.snert.com/Software/download/${PN}104.tgz"
LICENSE="BSD"
KEYWORDS="x86"
IUSE=""
SLOT="1"

APACHE1_MOD_CONF="${PVR}/28_mod_loopback"
APACHE1_MOD_DEFINE="LOOPBACK"

DOCFILES="CHANGES.txt LICENSE.txt"

need_apache1
