# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bw/mod_bw-0.6.ebuild,v 1.4 2006/01/17 16:52:04 nixnut Exp $

inherit eutils apache-module

MYP="bw_mod-${PV}"

DESCRIPTION="Bandwidth Management Module for Apache 2.0"
HOMEPAGE="http://www.ivn.cl/apache/"
SRC_URI="http://www.ivn.cl/apache/${MYP/_rc/rc}.tgz"

KEYWORDS="~amd64 ~ppc x86"
DEPEND=""
LICENSE="Apache-1.1"
SLOT="1"
IUSE=""

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="BW"

need_apache2

S=${WORKDIR}/${MYP/_rc*}

src_unpack() {
	unpack ${A} || die "unpack failed"
	mv ${S}/{${MYP/_rc/rc}.c,${PN}.c} || die "cannot move source file"
}
