# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/baghira/baghira-0.6e-r1.ebuild,v 1.1 2005/03/22 10:34:51 voxus Exp $

inherit kde

DESCRIPTION="Baghira - an OS-X like style for KDE"
HOMEPAGE="http://baghira.sourceforge.net/"
SRC_URI="mirror://sourceforge/baghira/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND="|| ( kde-base/kwin >=kde-base/kdebase-3.3 )"

need-kde 3.3

src_unpack() {
	kde_src_unpack
	if [	`kde-config --version | 		\
			grep KDE | awk '{print $2}' | 	\
			awk -F. '{ print $1$2 }'` 		\
		-lt 34 ]; then
		cd ${S}/deco && epatch ${FILESDIR}/${P}-drop_resize_handle.patch
	fi
}
