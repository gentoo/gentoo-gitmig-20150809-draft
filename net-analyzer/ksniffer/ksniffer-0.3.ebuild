# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ksniffer/ksniffer-0.3.ebuild,v 1.1 2007/08/23 21:33:38 philantrop Exp $

USE_KEG_PACKAGING=1
LANGS="ar bg br ca cs cy da de el en_GB es et fr ga gl it ka lt nl pa pt ru rw sk sr sr@Latn sv ta tr vi"

inherit kde

DESCRIPTION="A network sniffer for KDE"
HOMEPAGE="http://www.ksniffer.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.6.28
		>=net-libs/libpcap-0.9.5"
RDEPEND="${DEPEND}"

need-kde 3.3
