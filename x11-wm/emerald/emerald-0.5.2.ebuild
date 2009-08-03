# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/emerald/emerald-0.5.2.ebuild,v 1.5 2009/08/03 10:43:38 ssuominen Exp $

inherit gnome2

DESCRIPTION="Emerald window decorator, part of Compiz Fusion"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=x11-libs/gtk+-2.8
	>=x11-libs/libwnck-2.14.2
	>=x11-wm/compiz-0.6.2"
DEPEND="${RDEPEND}"

DOCS="TODO README AUTHORS"
