# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porthole/porthole-0.6.1.ebuild,v 1.1 2010/02/26 18:31:57 idl0r Exp $

EAPI="2"

inherit distutils

DESCRIPTION="A GTK+-based frontend to Portage"
HOMEPAGE="http://porthole.sourceforge.net"
SRC_URI="mirror://sourceforge/porthole/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="nls"
LANGS="de pl ru vi it fr tr"
for X in $LANGS; do IUSE="${IUSE} linguas_${X}"; done

RDEPEND=">=dev-lang/python-2.4[xml,threads]
	>=sys-apps/portage-2.1
	>=dev-python/pygtk-2.4.0
	>=gnome-base/libglade-2.5.0
	dev-python/pygtksourceview:2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.14 )"

src_compile(){
	# Compile localizations if necessary
	if use nls ; then
		cd scripts
		./pocompile.sh -emerge ${LINGUAS} || die "pocompile failed"
	fi
}

src_install() {
	distutils_src_install

	dodoc TODO README NEWS AUTHORS

	keepdir /var/log/porthole
	fperms g+w /var/log/porthole
	keepdir /var/db/porthole
	fperms g+w /var/db/porthole

	# nls
	if use nls; then
		# mo directory doesn't exists with nls enabled and unsupported LINGUAS
		[[ -d porthole/i18n/mo ]] && domo porthole/i18n/mo/*
	fi
}

pkg_preinst() {
	chgrp portage "${D}"/var/log/porthole
	chgrp portage "${D}"/var/db/porthole
}

pkg_postinst() {
	einfo
	einfo "Porthole has updated the way that the upgrades are sent to emerge."
	einfo "In this new way the user needs to set any 'Settings' menu emerge options"
	einfo "Porthole automatically adds '--oneshot' for all upgrades selections"
	einfo "Other options recommended are '--noreplace'  along with '--update'"
	einfo "They allow for portage to skip any packages that might have already"
	einfo "been upgraded as a dependency of another previously upgraded package"
	einfo
}
