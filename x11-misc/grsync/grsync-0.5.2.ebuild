# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grsync/grsync-0.5.2.ebuild,v 1.1 2007/02/03 12:21:38 dertobi123 Exp $

inherit eutils gnome2 autotools

DESCRIPTION="A gtk frontend to rsync"
HOMEPAGE="http://www.opbyte.it/grsync/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
SRC_URI="http://www.opbyte.it/release/${P}.tar.gz"

RDEPEND=">=x11-libs/gtk+-2.6
	net-misc/rsync"

DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS NEWS README"
