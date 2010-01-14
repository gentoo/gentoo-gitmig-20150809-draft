# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcheckgmail/kcheckgmail-0.6.0.ebuild,v 1.1 2010/01/14 14:41:43 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar ca cs da de el es et fr hu it ko lt pl pt_BR pt ru sk sv tr wa zh_CN"
inherit kde4-base

DESCRIPTION="A systray application that notifies when new email is received in a Gmail account"
HOMEPAGE="http://kcheckgmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DOCS="AUTHORS README TODO"
