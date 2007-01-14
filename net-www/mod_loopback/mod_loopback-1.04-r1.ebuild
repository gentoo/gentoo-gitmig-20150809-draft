# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_loopback/mod_loopback-1.04-r1.ebuild,v 1.4 2007/01/14 17:37:25 chtekk Exp $

inherit apache-module

KEYWORDS="x86"

DESCRIPTION="A web client debugging tool for Apache1."
HOMEPAGE="http://www.snert.com/Software/mod_loopback/index.shtml"
SRC_URI="http://www.snert.com/Software/download/${PN}104.tgz"
LICENSE="BSD"
SLOT="1"
IUSE=""

S="${WORKDIR}/${PN}-1.4"

APACHE1_MOD_CONF="28_mod_loopback"
APACHE1_MOD_DEFINE="LOOPBACK"

DOCFILES="CHANGES.txt LICENSE.txt"

need_apache1
