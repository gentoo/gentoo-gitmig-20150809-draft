# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_injection/mod_injection-0.3.1-r1.ebuild,v 1.1 2005/01/09 00:35:41 hollow Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 filtering module"
HOMEPAGE="http://pmade.org/pjones/software/mod_injection/"
SRC_URI="http://pmade.org/pjones/software/${PN}/download/${P}.tar.gz"

LICENSE="Apache-1.1"
KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="0"

APXS2_S="${S}"
APXS2_ARGS="-c src/${PN}.c"
APACHE2_MOD_FILE="src/.libs/${PN}.so"
APACHE2_MOD_CONF="${PVR}/23_mod_injection"
APACHE2_MOD_DEFINE="INJECTION"

DOCFILES="README INSTALL docs/CREDITS docs/manual.txt"

need_apache2
