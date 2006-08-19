# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/syncekonnector/syncekonnector-0.3_pre20060117.ebuild,v 1.3 2006/08/19 20:12:29 chriswhite Exp $

inherit eutils kde autotools

DESCRIPTION="Synchronize Windows CE devices with Linux.  KDE Konnector."
HOMEPAGE="http://synce.sourceforge.net/synce/kde/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-pda/synce-libsynce-0.9.1
	>=app-pda/synce-rra-0.9.1
	>=app-pda/orange-0.3
	>=app-arch/unshield-0.5
	|| ( =kde-base/ksync-3.5* =kde-base/kdepim-3.5* )
	app-pda/dynamite
	!app-pda/rapip"

need-kde 3.5

src_unpack() {
	kde_src_unpack
	cd "${S}"
	# :/
	mkdir -p ${S}/${PN}/libkdepim
	# >:/
	cp ${FILESDIR}/kpimprefs.h ${S}/${PN}/libkdepim
	# lalala please fix this upstream~
	epatch "${FILESDIR}"/syncekonnector-0.3_pre20060108-autotools.patch
}
