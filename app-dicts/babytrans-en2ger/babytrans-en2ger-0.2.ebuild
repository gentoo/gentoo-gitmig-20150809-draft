# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/babytrans-en2ger/babytrans-en2ger-0.2.ebuild,v 1.2 2004/09/22 20:40:19 angusyoung Exp $

MY_P="EngtoGer.dic.gz"
MY_F="Engtoger.dic"
DESCRIPTION="English to German dictionary for Babytrans"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/languages/babylon_dict/"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/languages/babylon_dict/${MY_P}"

# Needs checking
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="app-dicts/babytrans"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Due to license restrictions that may or may not apply to"
	einfo "this package, it now has fetch restrictions turned on. This"
	einfo "means that you must download ${MY_P} file manually from"
	einfo "${HOMEPAGE} or copy then"
	einfo "from a windows installation of babylon and put them in "
	einfo "${DISTDIR}. Finally note that having a license of"
	einfo "babylon is desired in order to use this package"
}

src_unpack() {
	local MY_A
	unpack ${A} || die "Unable to unpack file ${A}"
	MY_A="EngtoGer.dic"
	mv ${MY_A} ${MY_F} || die "Unable to rename file ${MY_A}"
}

src_install() {
	cd ${WORKDIR}
	insinto /usr/share/babytrans
	doins ${MY_F} || die "Unable to install file ${MY_F}"
}
