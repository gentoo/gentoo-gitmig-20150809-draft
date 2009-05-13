# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portpeek/portpeek-1.8.0.ebuild,v 1.1 2009/05/13 21:07:26 mpagano Exp $

DESCRIPTION="A helper program for maintaining the package.keyword and package.unmask files"
HOMEPAGE="http://www.mpagano.com/blog/?page_id=3"
SRC_URI="http://www.mpagano.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=app-portage/gentoolkit-0.2.4
	>=sys-apps/portage-2.2_rc23"

src_install() {
	dobin ${PN} || die "dobin failed"
	doman *.[0-9]
}

pkg_postinst() {
	ewarn "Portpeek versions >= 1.8.0 contain the -t flag for checking"
	ewarn "and removing ~ (tilde) unmasked packages."
	ewarn "This is a brand new feature and caution should be used when"
	ewarn "invoking it. (like maybe backing up your /etc/portage/* files)"
	ewarn "If you find any problems open a bug in bugzilla attaching the"
	ewarn " affected files from /etc/portage/* and assign it too me."
	ewarn "Your faithful Gentoo servant, mpagano@gentoo.org"
}

