# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/sshlpr/sshlpr-1.ebuild,v 1.1 2011/10/08 06:26:41 radhermit Exp $

EAPI="4"

DESCRIPTION="ssh-lpr backend for cups -- print to remote systems over ssh"
HOMEPAGE="http://www.masella.name/technical/sshlpr.html"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/openssh
	net-print/cups
	sys-apps/shadow"

S="${WORKDIR}"

src_install() {
	exeinto /usr/libexec/cups/backend
	exeopts -m0700
	doexe ${PN}
}
