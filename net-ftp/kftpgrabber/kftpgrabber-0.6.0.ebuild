# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kftpgrabber/kftpgrabber-0.6.0.ebuild,v 1.1 2005/05/27 14:13:20 greg_g Exp $

inherit kde

DESCRIPTION="A graphical FTP client for KDE."
HOMEPAGE="http://kftpgrabber.sourceforge.net/"
SRC_URI="http://kftpgrabber.sourceforge.net/releases/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

DEPEND="dev-libs/openssl"

# TODO: support for dev-libs/qsa

need-kde 3.3
