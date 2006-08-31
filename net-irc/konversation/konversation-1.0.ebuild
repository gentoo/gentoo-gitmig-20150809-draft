# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-1.0.ebuild,v 1.1 2006/08/31 21:49:35 flameeyes Exp $

LANGS="bg ca da de el en_GB es et fi fr hu it ja ka ko nl pt ru sr sr@Latn sv tr zh_TW"
LANGS_DOC="da es et it nl pt ru sv"

USE_KEG_PACKAGING=1

inherit kde

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.kde.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

need-kde 3
