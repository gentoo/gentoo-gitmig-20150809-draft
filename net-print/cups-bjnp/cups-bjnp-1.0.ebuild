# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-bjnp/cups-bjnp-1.0.ebuild,v 1.1 2011/10/08 18:22:59 vadimk Exp $

EAPI=3

inherit toolchain-funcs multilib

DESCRIPTION="CUPS backend for the canon printers using the proprietary USB over IP BJNP protocol."
HOMEPAGE="http://sourceforge.net/projects/cups-bjnp/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

src_install () {
	exeinto $(cups-config --serverbin)/backend
	doexe bjnp
}
