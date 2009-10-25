# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-0.9.4.ebuild,v 1.4 2009/10/25 12:39:30 ssuominen Exp $

ARTS_REQUIRED=never

inherit kde

MY_P=${P/_/-}

DESCRIPTION="Client for the NUT UPS monitoring daemon"
HOMEPAGE="http://www.knut.noveradsl.cz/knutclient/"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/knutclient/stable/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${MY_P}

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-xdg-desktop-entry.diff" )

src_unpack(){
	kde_src_unpack
	rm "${S}"/configure
}
