# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-i18n.eclass,v 1.26 2002/10/25 19:55:52 vapier Exp $

inherit kde
ECLASS=kde-i18n
INHERITED="$INHERITED $ECLASS"

S=${WORKDIR}/${PN}
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

SLOT="$KDEMAJORVER.$KDEMINORVER"

myconf="$myconf --enable-final"

need-kde ${PV}

case "$PV" in
	2.2.2)		SRC_PATH="stable/${PV}/src/${P}.tar.bz2" ;;
	3.1_beta1)	SRC_PATH="unstable/kde-3.1-beta1/src/kde-i18n/${P//3.1_beta1/3.0.7}.tar.bz2" ;;
	3.1_beta2)	SRC_PATH="unstable/kde-3.1-beta2/src/kde-i18n/${P//3.1_beta2/3.0.8}.tar.bz2" ;;
	3*)			SRC_PATH="stable/${PV}/src/kde-i18n/${P}.tar.bz2" ;;
esac

if [ "$PN" == "kde-i18n" ]; then
	SRC_PATH=${SRC_PATH/kde-i18n//}
fi

SRC_URI="$SRC_URI mirror://kde/$SRC_PATH
	http://www.ibiblio.org/gentoo/distfiles/kde-i18n-gentoo.patch"

kde-i18n_src_unpack() {
	unpack ${A//kde-i18n-gentoo.patch} || die
	cd ${S}
	if [ -f "docs/common/Makefile.in" ]; then
		patch -p0 < ${DISTDIR}/kde-i18n-gentoo.patch
		echo Please ignore possible errors about rejected patch above
	fi
}

EXPORT_FUNCTIONS src_unpack

