# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sshpass/sshpass-1.04-r1.ebuild,v 1.1 2011/05/26 13:55:14 hwoarang Exp $

EAPI="2"

inherit base

DESCRIPTION="Tool for noninteractively performing password authentication with ssh."
HOMEPAGE="http://sshpass.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/openssh"
DEPEND=""

DOCS="AUTHORS NEWS"

PATCHES=(
	"${FILESDIR}"/${P}-ssh5.6.patch
)
