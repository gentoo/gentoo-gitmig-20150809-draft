# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kwebget/kwebget-0.8.1.ebuild,v 1.2 2004/11/19 17:58:39 motaboy Exp $

inherit kde

DESCRIPTION="KWebGet - a KDE wget frontend"
SRC_URI="http://www.kpage.de/download/kwebget-0.8.1.tar.bz2"
HOMEPAGE="http://www.kpage.de/en/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

RDEPEND="$DEPEND
	>=net-misc/wget-1.9-r2"

S="${WORKDIR}/kwebget"

need-kde 3.0

src_unpack() {
	kde_src_unpack
	# respect the "alsa" USE flag until it's fixed upstream
	use arts || epatch ${FILESDIR}/kwebget-0.8.1-configure.patch
}

