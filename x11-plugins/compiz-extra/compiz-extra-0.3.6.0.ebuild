# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/compiz-extra/compiz-extra-0.3.6.0.ebuild,v 1.1 2007/01/28 12:36:48 hanno Exp $

inherit gnome2

DESCRIPTION="Compiz extra third party plugins"
HOMEPAGE="http://www.go-compiz.org/index.php?title=Download"
SRC_URI="http://gandalfn.club.fr/ubuntu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-wm/compiz-0.3.6"
