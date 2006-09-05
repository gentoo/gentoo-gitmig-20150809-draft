# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/system-config-base/system-config-base-1.ebuild,v 1.1 2006/09/05 20:49:21 dberkholz Exp $

inherit eutils

DESCRIPTION="system-config-* layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="virtual/pam"

S=${WORKDIR}

src_install() {
	dopamd ${FILESDIR}/config-util
}

pkg_postinst() {
	if [ "$(stat -c%a ${ROOT}etc/default/useradd)" != "644" ] ; then
		echo
		ewarn
		ewarn "Your ${ROOT}etc/default/useradd file must be world-readable"
		ewarn "  for the system-config-* utilities to work properly."
		ewarn "  If you did not change them on purpose, consider running:"
		ewarn
		echo -e "\tchmod 0644 ${ROOT}etc/default/useradd"
		echo
	fi
}
