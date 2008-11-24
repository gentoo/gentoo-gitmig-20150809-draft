# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/adaptit/adaptit-4.0.2.ebuild,v 1.1 2008/11/24 06:00:45 kanaka Exp $

WX_GTK_VER=2.8

inherit eutils wxwidgets flag-o-matic fdo-mime

DESCRIPTION="Application for translating text from one known language to another related language."
SRC_URI="http://adaptit.martintribe.org/apt/pool/main/a/adaptit/adaptit_4.0.2.orig.tar.gz"
HOMEPAGE="http://code.google.com/p/adaptit/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=x11-libs/wxGTK-2.8"
DEPEND="
	${RDEPEND}
	sys-devel/gettext"

src_compile() {
	append-flags -fno-strict-aliasing

	mkdir -p ${S}/build
	cd ${S}/build

	ECONF_SOURCE=${S}/bin/linux/
	econf \
		|| die "Configure failed!"

	emake || die "Build failed!"
}

src_install () {
	cd ${S}/build
	emake DESTDIR="${D}" install || die "Install failed"
	cd ${S}
	dodoc AUTHORS ChangeLog
	cd ${S}/license
	dodoc LICENSING.txt
}
