# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-python/eselect-python-20090606.ebuild,v 1.8 2009/08/25 17:31:16 arfrever Exp $

DESCRIPTION="Manages multiple Python versions"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/python.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.2"

pkg_setup() {
	if has_version ">=app-admin/eselect-python-20090804"; then
		die "Downgrade of app-admin/eselect-python is not supported"
	fi
}

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}/python.eselect-${PVR}" python.eselect || die "newins python.eselect failed"
}
