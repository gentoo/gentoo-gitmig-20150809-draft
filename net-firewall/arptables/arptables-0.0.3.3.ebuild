# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/arptables/arptables-0.0.3.3.ebuild,v 1.1 2007/08/29 11:25:02 pva Exp $

inherit versionator eutils

MY_P=${PN}-v$(replace_version_separator 3 - )

DESCRIPTION="set up, maintain, and inspect the tables of ARP rules in the Linux kernel"
HOMEPAGE="http://ebtables.sourceforge.net/"
SRC_URI="mirror://sourceforge/ebtables/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}"/${MY_P}

src_compile() {
	emake CC="$(tc-getCC)" COPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	into /
	dosbin arptables arptables-restore arptables-save
	doman arptables.8
}
