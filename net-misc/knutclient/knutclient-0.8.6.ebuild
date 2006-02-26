# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-0.8.6.ebuild,v 1.2 2006/02/26 19:55:43 dertobi123 Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Client for the NUT UPS monitoring daemon"
HOMEPAGE="http://www.alo.cz/knutclient-pop-en.html"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/knutclient/stable/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE=""

need-kde 3.1

src_unpack() {
	kde_src_unpack
	use arts || epatch ${FILESDIR}/${PN}-0.8.5-arts-configure.patch
}
