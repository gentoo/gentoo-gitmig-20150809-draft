# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kasablanca/kasablanca-0.4.0.2.ebuild,v 1.9 2007/08/20 23:14:28 philantrop Exp $

inherit kde eutils

DESCRIPTION="A graphical ftp client for KDE. It supports ssl/tls encryption, fxp, bookmarks, and queues"
HOMEPAGE="http://kasablanca.berlios.de/"
SRC_URI="http://download.berlios.de/kasablanca/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

need-kde 3.1

src_unpack() {
	kde_src_unpack
	# Fix for 64-bit archs. Patch applied upstream.
	epatch "${FILESDIR}"/${P}-64bit.patch
	# Fixes the desktop file. cf. bug 187371
	epatch "${FILESDIR}"/${P}-desktop-file.patch
}
