# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kiso/kiso-0.8.3.ebuild,v 1.10 2009/06/13 13:29:53 tampakrap Exp $

inherit kde

DESCRIPTION="a frontend for KDE to make it as easy as possible to create manipulate and extract CD Image files."
HOMEPAGE="http://kiso.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiso/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-libs/libcdio-0.73
	virtual/cdrtools
	app-admin/sudo"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-libcdio-077.patch
	"${FILESDIR}"/${PN}-desktop_file.patch )

need-kde 3.2

S=${WORKDIR}/${P/c}

src_install() {
	kde_src_install

	rm -Rf "${D}"/usr/share/applnk
	domenu "${S}"/src/${PN}.desktop
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
