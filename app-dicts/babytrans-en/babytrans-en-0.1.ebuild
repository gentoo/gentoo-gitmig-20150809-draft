# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/babytrans-en/babytrans-en-0.1.ebuild,v 1.1 2004/09/10 05:32:30 angusyoung Exp $

MY_P="english.dic.gz"
MY_F="english.dic"
DESCRIPTION="English dictionary for Babytrans"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/languages/babylon_dict/"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/languages/babylon_dict/${MY_P}"

#I was not able to discover what is the license of this file. 
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND=""
S=${WORKDIR}/${P}

src_unpack() {
	local MY_A
	unpack ${A} || die "Unable to unpack file ${A}"
}

src_install() {
	cd ${WORKDIR}
	insinto /usr/share/babytrans
	doins ${MY_F} || die "Unable to install file"
}
