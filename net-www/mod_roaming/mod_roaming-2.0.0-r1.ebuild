# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_roaming/mod_roaming-2.0.0-r1.ebuild,v 1.1 2005/01/09 00:24:14 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Apache2 DSO enabling Netscape Communicator roaming profiles"
HOMEPAGE="http://www.klomp.org/mod_roaming/"

S=${WORKDIR}/${P}
SRC_URI="http://www.klomp.org/${PN}/${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE=""
SLOT="0"
APACHE2_MOD_CONF="${PVR}/18_mod_roaming"
DOCFILES="CHANGES INSTALL LICENSE README"
APXS2_S="${S}"
APXS2_ARGS="-c ${PN}.c"

need_apache2

# Don't know why we need this patch. Mark Dierolf <smark@3e0.com>
#src_unpack() {
#	unpack ${A} || die; cd ${S} || die
#	epatch ${FILESDIR}/mod_roaming-register.patch
#}

pkg_postinst() {
	#empty
	install -d -m 0755 -o apache -g apache ${ROOT}/var/lib/mod_roaming
}
