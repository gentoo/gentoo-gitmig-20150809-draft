# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vmaid/vmaid-1.8.15.ebuild,v 1.1 2004/03/01 16:12:00 matsuu Exp $

inherit gnome2

DESCRIPTION="Video maid is the AVI file editor"
HOMEPAGE="http://vmaid.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/vmaid/8438/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper"
