# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict/stardict-2.0.0.ebuild,v 1.2 2003/05/21 08:25:01 liquidx Exp $

inherit gnome2

IUSE=""
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P/-pre2/}
DESCRIPTION="A Gnome2 English-Chinese dictionary with fuzzy search."
HOMEPAGE="http://forlinux.yeah.net http://cosoft.org.cn/projects/stardict/"
SRC_URI="http://reciteword.cosoft.org.cn/yaoguang/myapps/${MY_P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=gnome-base/libbonobo-2.2.0
	>=gnome-base/libgnome-2.2.0
	>=gnome-base/libgnomeui-2.2.0
	>=gnome-base/bonobo-activation-2.2.0"
	
src_unpack() {
	unpack ${A}
	gnome2_omf_fix
}
