# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-i18n.eclass,v 1.31 2002/11/01 12:06:42 danarmak Exp $

inherit kde
ECLASS=kde-i18n
INHERITED="$INHERITED $ECLASS"

S=${WORKDIR}/${PN}
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

SLOT="$KDEMAJORVER.$KDEMINORVER"

set_enable_final

need-kde ${PV}

case "$PV" in
	2.2.2)		SRC_PATH="stable/${PV}/src/${P}.tar.bz2"
			KEYWORDS="x86 ppc";;
	3.1_beta1)	SRC_PATH="unstable/kde-3.1-beta1/src/kde-i18n/${P//3.1_beta1/3.0.7}.tar.bz2" 
			KEYWORDS="x86 ppc";;
	3.1_beta2)	SRC_PATH="unstable/kde-3.1-beta2/src/kde-i18n/${P//3.1_beta2/3.0.8}.tar.bz2" 
			KEYWORDS="x86 ppc";;
	3.1_rc1)	SRC_PATH="unstable/kde-3.1-beta2/src/kde-i18n/${P//3.1_rc1/3.0.9}.tar.bz2" 
			KEYWORDS="x86 ppc";;
	3*)		SRC_PATH="stable/${PV}/src/kde-i18n/${P}.tar.bz2" 
			KEYWORDS="x86 ppc";;
esac

if [ "$PN" == "kde-i18n" ]; then
	SRC_PATH=${SRC_PATH/kde-i18n//}
fi

SRC_URI="$SRC_URI mirror://kde/$SRC_PATH"

kde-i18n_src_unpack() {
	unpack ${A//kde-i18n-gentoo.patch} || die
	cd ${S}
	if [ -f "docs/common/Makefile.in" ]; then
		# this enables destdir!=kdelibsdir
		cd docs/common
		cp Makefile.in Makefile.in.orig
		sed -e 's:(kde_htmldir)/en/common:(kde_libs_htmldir)/en/common:g' Makefile.in.orig > Makefile.in
	fi
}

kde-i18n_src_compile() {

	kde_src_compile myconf
	myconf="$myconf --prefix=$KDEDIR"
	kde_src_compile configure
	# don't run make; there's nothing for it to do really, and we'd just waste time
	# if there's anything it wants to do it'll get done during make install,
	# but there's no compiling here

}

EXPORT_FUNCTIONS src_unpack src_compile

