# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_DNS2/PEAR-Net_DNS2-1.1.2-r1.ebuild,v 1.1 2011/10/15 10:18:47 olemarkus Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Object-oriented PHP5 resolver library used to communicate with a DNS server."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/php[sockets]"
