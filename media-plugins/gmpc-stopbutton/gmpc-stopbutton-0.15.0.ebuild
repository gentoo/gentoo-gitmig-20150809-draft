# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-stopbutton/gmpc-stopbutton-0.15.0.ebuild,v 1.3 2008/01/17 16:25:00 flameeyes Exp $

DESCRIPTION="This plugin adds a stop button to the controls in the main window."
HOMEPAGE="http://sarine.nl/gmpc-plugins-stopbutton"
SRC_URI="http://download.sarine.nl/gmpc-${PV}/plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
		dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile ()
{
	econf || die
	emake || die
}

src_install ()
{
	make DESTDIR="${D}" install || die
}
