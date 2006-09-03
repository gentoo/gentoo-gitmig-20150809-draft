# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/systempreferences/systempreferences-1.0.1.ebuild,v 1.1 2006/09/03 20:14:35 grobian Exp $

inherit gnustep

DESCRIPTION="System Preferences is a clone of Apple OS X' System Preferences"
HOMEPAGE="http://www.gnustep.it/enrico/system-preferences/"
SRC_URI="http://www.gnustep.it/enrico/system-preferences/${P}.tar.gz"

KEYWORDS="~ppc x86 amd64"
LICENSE="GPL-2"
SLOT="0"

IUSE=""

DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

DIRS="PreferencePanes SystemPreferences Modules"

src_unpack() {
	unpack ${A}
	cd ${S}

	egnustep_env

	echo "ADDITIONAL_INCLUDE_DIRS += -I${S}" >> SystemPreferences/GNUmakefile.preamble
	echo "ADDITIONAL_LIB_DIRS += -L${S}/PreferencePanes/PreferencePanes.framework/Versions/Current -L${S}/PreferencePanes/PreferencePanes.framework/Versions/Current/$GNUSTEP_HOST_CPU/$GNUSTEP_HOST_OS/$LIBRARY_COMBO" >> SystemPreferences/GNUmakefile.preamble

	echo "ADDITIONAL_INCLUDE_DIRS += -I${S}" >> Modules/GNUmakefile.preamble
	echo "ADDITIONAL_LIB_DIRS += -L${S}/PreferencePanes/PreferencePanes.framework/Versions/Current -L${S}/PreferencePanes/PreferencePanes.framework/Versions/Current/$GNUSTEP_HOST_CPU/$GNUSTEP_HOST_OS/$LIBRARY_COMBO" >> Modules/GNUmakefile.preamble

	cd Modules
	for target in `find . -type d -maxdepth 1`;
	do
	    echo "ADDITIONAL_INCLUDE_DIRS += -I${S}" >> ${target}/GNUmakefile.preamble
	    echo "ADDITIONAL_LIB_DIRS += -L${S}/PreferencePanes/PreferencePanes.framework/Versions/Current -L${S}/PreferencePanes/PreferencePanes.framework/Versions/Current/$GNUSTEP_HOST_CPU/$GNUSTEP_HOST_OS/$LIBRARY_COMBO" >> ${target}/GNUmakefile.preamble
	done
}

src_compile() {
	egnustep_env

	for i in ${DIRS};
	do
	    cd "${S}/${i}"
	    egnustep_make || die
	done
}

src_install() {
	egnustep_env

	for i in ${DIRS}
	do
	    cd "${S}/${i}"
	    egnustep_install || die
	done
}

