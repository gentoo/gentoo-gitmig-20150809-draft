# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.2.1.ebuild,v 1.1 2004/07/27 00:03:27 pythonhead Exp $

inherit eutils kde

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
SRC_URI="mirror://sourceforge/poedit/${P}.tar.bz2"
HOMEPAGE="http://poedit.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.3.4
	=sys-libs/db-3*"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install () {

	# in case KDEDIR is empty
	local MY_KDEDIR
	if [ -n "${KDEDIR}" ]; then
		MY_KDEDIR=${KDEDIR}
	else
		MY_KDEDIR=/usr
	fi

	einstall \
		datadir=${D}/usr/share \
		GNOME_DATA_DIR=${D}/usr/share \
		KDE_DATA_DIR=${D}/${MY_KDEDIR}/share || die

	dodoc AUTHORS LICENSE NEWS README TODO
}
