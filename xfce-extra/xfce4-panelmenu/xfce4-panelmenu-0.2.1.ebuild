# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-panelmenu/xfce4-panelmenu-0.2.1.ebuild,v 1.1 2005/02/28 21:41:32 bcowan Exp $

PLUGIN=1
inherit xfce4

MY_P="${MY_P/panelmenu/panel-menu}"

DESCRIPTION="Xfce4 panel cpu load graphing plugin"
SRC_URI="http://download.berlios.de/${PN/-/}/${MY_P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

XFCE_S="${WORKDIR}/${MY_P}"
