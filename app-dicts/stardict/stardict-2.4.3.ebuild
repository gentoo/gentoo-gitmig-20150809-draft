# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict/stardict-2.4.3.ebuild,v 1.2 2004/11/22 21:34:48 jhuebel Exp $

inherit gnome2 eutils

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
KEYWORDS="~x86 ~ppc ~amd64"


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

	# Fix gtk-2.4 deprecation issues
	cd ${S}
	epatch ${FILESDIR}/stardict-gtk24.patch
}

src_install() {
	gnome2_src_install
	# dictionary index generation files
	exeinto /usr/share/stardict/tools
	doexe ${S}/src/tools/{dictd2dic,directory2dict,olddic2newdic,oxford2dic,pydict2dict,wquick2dict,stardict_dict_update}
}

pkg_postinst() {
	einfo "You will now need to install stardict dictionary files. If"
	einfo "you have not, execute the below to get a list of dictionaries:"
	einfo " "
	einfo "  emerge -s stardict-"
	einfo " "
	ewarn "If you upgraded from 2.4.1 or lower and use your own dictionary"
	ewarn "files, you'll need to run: /usr/share/stardict/tools/stardict_dict_update"
}
