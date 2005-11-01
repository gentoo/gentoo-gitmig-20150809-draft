# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_injection/mod_injection-0.3.1-r1.ebuild,v 1.4 2005/11/01 18:51:42 dertobi123 Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 filtering module"
HOMEPAGE="http://pmade.org/pjones/software/mod_injection/"
SRC_URI="http://pmade.org/pjones/software/${PN}/download/${P}.tar.gz"

LICENSE="Apache-1.1"
KEYWORDS="ppc x86"
IUSE=""
SLOT="0"

APACHE2_MOD_CONF="${PVR}/23_${PN}"
APACHE2_MOD_DEFINE="INJECTION"

DOCFILES="README INSTALL docs/CREDITS docs/manual.txt"

need_apache2
