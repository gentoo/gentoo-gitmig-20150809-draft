# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-stopbutton/gmpc-stopbutton-0.15.0.ebuild,v 1.1 2007/07/04 22:52:54 ticho Exp $

DESCRIPTION="This plugin adds a stop button to the controls in the main window."
HOMEPAGE="http://sarine.nl/gmpc-plugins-stopbutton"
SRC_URI="http://download.sarine.nl/gmpc-${PV}/plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-sound/gmpc-${PV}
		dev-libs/libxml2"

src_compile ()
{
	econf || die
	emake || die
}

src_install ()
{
	make DESTDIR="${D}" install || die
}
