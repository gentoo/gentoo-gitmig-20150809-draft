# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-panelmenu/xfce4-panelmenu-0.3.1-r1.ebuild,v 1.1 2005/10/06 17:41:51 bcowan Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel menu plugin"
MY_P="${PN/panelmenu/panel-menu-plugin-${PV}}"
SRC_URI="http://download.berlios.de/${PN/-/}/${MY_P}.tar.gz"
HOMEPAGE="https://developer.berlios.de/projects/xfce4panelmenu"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

plugin
