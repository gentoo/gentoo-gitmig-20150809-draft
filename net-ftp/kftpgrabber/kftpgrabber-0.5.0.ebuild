# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kftpgrabber/kftpgrabber-0.5.0.ebuild,v 1.2 2005/02/04 22:47:26 luckyduck Exp $

inherit kde

DESCRIPTION="A graphical FTP client for KDE."
HOMEPAGE="http://kftpgrabber.sourceforge.net/"
SRC_URI="http://kftpgrabber.sourceforge.net/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7d-r1
		>=x11-libs/qt-3.3.2
		>=net-misc/howl-0.9.6"

need-kde 3.2

