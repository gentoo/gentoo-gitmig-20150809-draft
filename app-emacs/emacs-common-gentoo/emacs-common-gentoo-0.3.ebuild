# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-common-gentoo/emacs-common-gentoo-0.3.ebuild,v 1.3 2009/04/12 13:53:08 ulm Exp $

inherit eutils fdo-mime gnome2-utils

# package moved from emacs-desktop to emacs-common-gentoo
MY_P=emacs-desktop-${PV}
DESCRIPTION="Desktop entry and icon for Emacs"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_install() {
	local i
	domenu emacs.desktop emacsclient.desktop
	newicon emacs_48.png emacs.png
	for i in 16 24 32 48; do
		insinto /usr/share/icons/hicolor/${i}x${i}/apps
		newins emacs_${i}.png emacs.png
	done
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
