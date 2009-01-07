# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/iceicons/iceicons-0.10.0.ebuild,v 1.9 2009/01/07 14:53:39 ranger Exp $

DESCRIPTION="IceWM Icons is a set of XPM 16x16, 32x32, and 48x48 XPM and PNG icons for IceWM"
HOMEPAGE="http://themes.freshmeat.net/projects/iceicons/"
SRC_URI="http://themes.freshmeat.net/redir/iceicons/35147/url_tgz/${PN}-default-${PV}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-wm/icewm-1.2.6"
DEPEND="${RDEPEND}
	app-arch/gzip
	app-arch/tar"

S="${WORKDIR}"
ICEICONSDIR="/usr/share/icewm/icons/iceicons"

src_install() {
	dodir ${ICEICONSDIR}
	cp -pPR icons/* ${D}/${ICEICONSDIR}
	chown -R root:0 ${D}/${ICEICONSDIR}
	chmod -R o-w ${D}/${ICEICONSDIR}

	dodoc CHANGELOG README TODO winoptions
}

pkg_postinst() {
	einfo
	einfo "To use new IceWm icons, add following"
	einfo "into your IceWm preference file:"
	einfo "IconPath=\"${ICEICONSDIR}:${ICEICONSDIR}/menuitems\""
	einfo
}

pkg_postrm(){
	einfo
	einfo "Update your IceWm preference."
	einfo
}
