# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws/sylpheed-claws-2.6.1.ebuild,v 1.11 2007/04/12 09:37:03 ticho Exp $

IUSE=""
DESCRIPTION="Sylpheed-Claws is an email client (and news reader) based on GTK+"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
RDEPEND=">=mail-client/claws-mail-${PV}"

pkg_postinst() {
	elog "Sylpheed Claws has been renamed to Claws Mail."
	elog "You can now unmerge mail-client/sylpheed-claws package, as Claws Mail"
	elog "is now installed on your system in its place."
	elog "You can use following script to migrate plugins to Claws Mail:"
	elog "/bin/bash ${FILESDIR}/plugins-rebuild.sh"
}
