# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmailcvt/kmailcvt-4.3.3.ebuild,v 1.4 2009/11/30 06:54:58 josejx Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KMail Import Filters"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND="
	app-crypt/gpgme
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	kmail/
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_QGpgme=ON"

	kde4-meta_src_configure
}
