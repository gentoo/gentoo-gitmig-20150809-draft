# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbfx/kbfx-0.4.9.2_pre4.ebuild,v 1.1 2006/12/13 21:51:46 genstef Exp $

inherit kde eutils
need-kde 3.3

MY_P="${PN}-0.4.9.2rc4"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="KDE alternative K-Menu"
HOMEPAGE="http://www.kbfx.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
export UNSERMAKE=no
