# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-geolocation/claws-mail-geolocation-0.0.7.ebuild,v 1.1 2011/12/26 11:08:22 fauli Exp $

EAPI=3

MY_P="geolocation_plugin-${PV}"

DESCRIPTION="GeoLocation functionality for Claws Mail"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Check if other versions of libchamplain ship the same pc file
RDEPEND=">=mail-client/claws-mail-3.8.0
	media-libs/clutter-gtk:0.10
	media-libs/libchamplain:0.8[gtk]
	sys-devel/gettext"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
