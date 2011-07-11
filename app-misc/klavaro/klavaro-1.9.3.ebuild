# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/klavaro/klavaro-1.9.3.ebuild,v 1.1 2011/07/11 17:37:41 scarabeus Exp $

EAPI=4

DESCRIPTION="Another free touch typing tutor program"
HOMEPAGE="http://klavaro.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	>=x11-libs/gtk+-2.16.6:2
	x11-libs/gtkdatabox"

DEPEND="${RDEPEND}
	sys-devel/gettext"

DOCS=( AUTHORS ChangeLog NEWS README TODO )
