# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ibm-powerpc-utils/ibm-powerpc-utils-1.0.2.ebuild,v 1.1 2006/04/19 20:11:02 ranger Exp $

inherit eutils

MY_P="powerpc-utils-${PV}"

DESCRIPTION="The powerpc-utils package provides utilities for the maintainance
of the IBM and Apple powerpc platforms.  It includes nvram, bootlist,
ofpathname, and snap."
SRC_URI="http://powerpc-utils.ozlabs.org/releases/${MY_P}.tar.gz"
HOMEPAGE="http://powerpc-utils.ozlabs.org/"

S="${WORKDIR}/${MY_P}"

SLOT="0"
LICENSE="IPL-1"
KEYWORDS="~ppc ~ppc64"
IUSE=""
DEPEND="sys-libs/librtas
sys-devel/bc"
RDEPEND="!sys-apps/ppc64-utils"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/ibm-powerpc-utils-1.0.2-remove-doc.patch
}

src_install() {
	make DESTDIR="${D}" install || die "Something went wrong"
#	dodoc README COPYRIGHT

}

pkg_postinst() {
	einfo "If you are running IBM hardware, consider emerging "
	einfo "sys-apps/ibm-powerpc-utils-papr for additional functions. "
}
