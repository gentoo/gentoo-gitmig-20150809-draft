# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kwebget/kwebget-0.8.1.ebuild,v 1.6 2005/10/12 13:00:59 greg_g Exp $

inherit kde eutils

DESCRIPTION="A KDE frontend for wget."
HOMEPAGE="http://www.kpage.de/en/"
SRC_URI="http://www.kpage.de/download/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""

RDEPEND=">=net-misc/wget-1.9-r2"

need-kde 3

S="${WORKDIR}/${PN}"

src_unpack() {
	kde_src_unpack

	# respect the "arts" USE flag until it's fixed upstream
	use arts || epatch ${FILESDIR}/kwebget-0.8.1-configure.patch
}
