# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict/stardict-2.4.1.ebuild,v 1.8 2004/10/05 12:31:31 pvdabeel Exp $

inherit gnome2

# NOTE: Even though the *.dict.dz are the same as dictd/freedict's files,
#       their indexes seem to be in a different format. So we'll keep them
#       seperate for now.

IUSE=""
DESCRIPTION="A GNOME2 international dictionary supporting fuzzy and glob style matching"
HOMEPAGE="http://stardict.sourceforge.net/ http://cosoft.org.cn/projects/stardict/"
SRC_URI="mirror://sourceforge/stardict/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# when adding keywords, remember to add to stardict.eclass
KEYWORDS="x86 ppc"


RDEPEND=">=gnome-base/libbonobo-2.2.0
	>=gnome-base/libgnome-2.2.0
	>=gnome-base/libgnomeui-2.2.0
	>=sys-libs/zlib-1.1.4
	>=gnome-base/gconf-1.2
	>=dev-libs/popt-1.7
	>=gnome-base/orbit-2.6
	>=x11-libs/gtk+-2
	app-text/scrollkeeper"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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

CFLAGS="${CFLAGS} \
	-UG_DISABLE_DEPRECATED \
	-UGDK_DISABLE_DEPRECATED \
	-UGDK_PIXBUF_DISABLE_DEPRECATED \
	-UGTK_DISABLE_DEPRECATED \
	-UGNOME_DISABLE_DEPRECATED"

CXXFLAGS="${CXXFLAGS} \
	-UG_DISABLE_DEPRECATED \
	-UGDK_DISABLE_DEPRECATED \
	-UGDK_PIXBUF_DISABLE_DEPRECATED \
	-UGTK_DISABLE_DEPRECATED \
	-UGNOME_DISABLE_DEPRECATED"
