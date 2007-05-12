# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/klamav/klamav-0.41.ebuild,v 1.5 2007/05/12 14:18:18 corsair Exp $

inherit kde

MY_P="${P}-source"
S="${WORKDIR}/${MY_P}/${P}"

DESCRIPTION="KlamAV is a KDE frontend for the ClamAV antivirus."
HOMEPAGE="http://klamav.sourceforge.net/"
SRC_URI="mirror://sourceforge/klamav/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=app-antivirus/clamav-0.90"
RDEPEND="${DEPEND}"

need-kde 3.4

PATCHES="${FILESDIR}/${P}-cl_loaddbdir.patch"

src_unpack(){
	kde_src_unpack
	# Assure a future version won't try to build this.
	rm -rf ${WORKDIR}/${MY_P}/dazuko* || die "We missed to eradicate some files"
}

pkg_postinst(){
	elog "The on-access scanning functionality is provided by"
	elog "the Dazuko kernel module:  emerge sys-fs/dazuko"
}
