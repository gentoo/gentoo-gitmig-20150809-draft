# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.22-r1.ebuild,v 1.2 2005/02/09 15:47:30 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted"
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
HOMEPAGE="http://dominia.org/djao/limitipconn2.html"

KEYWORDS="~x86 ~ppc"
SLOT="2"
LICENSE="as-is"
IUSE=""

APACHE2_MOD_CONF="27_mod_limitipconn"
APACHE2_MOD_DEFINE="LIMITIP"

DOCFILES="ChangeLog INSTALL README"

need_apache2
