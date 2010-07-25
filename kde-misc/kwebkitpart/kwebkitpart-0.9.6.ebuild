# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kwebkitpart/kwebkitpart-0.9.6.ebuild,v 1.1 2010/07/25 23:45:06 reavertm Exp $

EAPI="2"

KDE_LINGUAS="bg cs da de el en_GB eo es et fi fr ga gl hu it km lt ms nb nds nl
pa pt pt_BR ro ru sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv tg th tr uk
zh_CN zh_TW"

WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="A WebKit KPart for konqueror"
HOMEPAGE="http://opendesktop.org/content/show.php?content=127960"
SRC_URI="http://opendesktop.org/CONTENT/content-files/127960-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"
