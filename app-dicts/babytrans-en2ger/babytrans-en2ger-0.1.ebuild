# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/babytrans-en2ger/babytrans-en2ger-0.1.ebuild,v 1.1 2004/09/10 06:20:52 angusyoung Exp $

MY_P="EngtoGer.dic.gz"
MY_F="Engtoger.dic"
DESCRIPTION="English to German dictionary for Babytrans"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/languages/babylon_dict/"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/languages/babylon_dict/${MY_P}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""
S=${WORKDIR}/${P}

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
