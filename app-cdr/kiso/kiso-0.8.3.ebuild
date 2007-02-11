# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kiso/kiso-0.8.3.ebuild,v 1.8 2007/02/11 00:02:32 troll Exp $

inherit kde

DESCRIPTION="KIso is a fronted for KDE to make it as easy as possible to create manipulate and extract CD Image files."
HOMEPAGE="http://kiso.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiso/${P}.tar.gz"
S="${WORKDIR}/${P/c/}"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libcdio-0.73"
RDEPEND="${DEPEND}
	virtual/cdrtools
	app-admin/sudo"

PATCHES="${FILESDIR}/${P}-libcdio-077.patch
	${FILESDIR}/${PN}-desktop_file.patch"

need-kde 3.2

src_install() {
	kde_src_install

	rm -Rf ${D}/usr/share/applnk
	domenu ${S}/src/${PN}.desktop
}

pkg_postinst() {
	elog
	elog "Applications KIso will use when available:"
	elog
	elog "to burn cd images         - app-cdr/k3b"
	elog "to create encypted images - app-crypt/mcrypt"
	elog "to hex edit images        - kdebase/khexedit, kdebase/kdeutils or app-editors/ghex"
	elog
}
