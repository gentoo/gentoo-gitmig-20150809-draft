# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-geolocation/claws-mail-geolocation-0.0.4.ebuild,v 1.4 2011/03/06 13:18:12 fauli Exp $

EAPI=3

inherit autotools

MY_P="geolocation_plugin-${PV}"

DESCRIPTION="GeoLocation functionality for Claws Mail"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Check if other versions of libchamplain ship the same pc file
RDEPEND=">=mail-client/claws-mail-3.7.6
	media-libs/clutter-gtk:0.10
	=media-libs/libchamplain-0.6*[gtk]
	sys-devel/gettext"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# geolocation checks for the exact version, so fix the code
	# see bug 326981
	sed -e "s:champlain-gtk-0.4:champlain-gtk-0.6:" -i "${S}"/configure.ac || die
	eautoconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
