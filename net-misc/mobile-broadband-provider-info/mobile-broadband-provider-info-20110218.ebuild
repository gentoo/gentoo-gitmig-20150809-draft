# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mobile-broadband-provider-info/mobile-broadband-provider-info-20110218.ebuild,v 1.1 2011/02/19 14:20:17 nirbheek Exp $

inherit gnome.org

DESCRIPTION="Database of mobile broadband service providers"
HOMEPAGE="http://live.gnome.org/NetworkManager/MobileBroadband/ServiceProviders"
# Weird bug in gnome.org causes a dot to be added in uri
SRC_URI="${SRC_URI/${PV}./${PV}}"

LICENSE="CC-PD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README || die "dodoc failed"
}
