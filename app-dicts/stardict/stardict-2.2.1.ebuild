# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict/stardict-2.2.1.ebuild,v 1.1 2003/07/01 10:02:26 liquidx Exp $

inherit gnome2

# NOTE: Even though the *.dict.dz are the same as dictd/freedict's files,
#       their indexes seem to be in a different format. So we'll keep them
#       seperate for now.

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME2 international dictionary supporting fuzzy and glob style matching"
HOMEPAGE="http://stardict.sourceforge.net/ http://cosoft.org.cn/projects/stardict/"
SRC_URI="mirror://sourceforge/stardict/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# when adding keywords, remember to add to stardict.eclass
KEYWORDS="~x86"


DEPEND=">=gnome-base/libbonobo-2.2.0
	>=gnome-base/libgnome-2.2.0
	>=gnome-base/libgnomeui-2.2.0
	>=gnome-base/bonobo-activation-2.2.0
	>=sys-libs/zlib-1.1.4
	>=gnome-base/gconf-1.2
	>=dev-libs/popt-1.7
	>=gnome-base/ORBit2-2.6"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix
}

src_install() {
	gnome2_src_install
	# dictionary index generation files
	insinto /usr/share/stardict/tools
	doins ${S}/tools/{dictd2dic,directory2dict,olddic2newdic,oxford2dic,pydict2dict,wquick2dict}
}

pkg_postinst() {
	einfo "You will now need to install stardict dictionary files. If"
	einfo "you have not, execute the below to get a list of dictionaries:"
	echo
	einfo "  emerge -s stardict-"
}
