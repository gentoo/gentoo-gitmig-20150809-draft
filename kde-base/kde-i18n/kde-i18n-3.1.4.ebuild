# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.1.4.ebuild,v 1.1 2003/09/19 21:57:14 caleb Exp $

inherit kde
need-kde ${PV}

DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="$KDEMAJORVER.$KDEMINORVER"

LANGS="af ar bg bs ca cs da de el es en_GB eo es et eu fa fi fr he hr hu is it
ja lt mk mt bn nl nn nso pl pt pt_BR ro ru se sk sl sr ss sv ta th tr uk ven vi xh
zh_CN zh_TW zu"

BASEDIR="mirror://kde/stable/${PV}/src/kde-i18n/"

#Maybe this isn't the smartest way of doing things, but it works
#for the purposes of this ebuild.
USE="${USE} ${LINGUAS}"

if [ -z "${LINGUAS}" ]; then
	ewarn "Using the LINGUAS environment variable, you can download only"
	ewarn "language packages you are interested in.  Currently you are"
	ewarn "downloading all languages available."

	SRC_URI="$BASEDIR/kde-i18n-${PV}.tar.bz2"
else
	for pkg in $LANGS
	do
		if [ `use ${pkg}` ] ; then
			SRC_URI="$SRC_URI $BASEDIR/kde-i18n-$pkg-${PV}.tar.bz2"
			echo "using package ${pkg}"
		fi
	done
fi

src_unpack() {
	base_src_unpack unpack
}

src_compile() {
	for dir in `ls ${WORKDIR}`; do
		cd ${WORKDIR}/$dir
		kde_src_compile myconf
		myconf="$myconf --prefix=$KDEDIR -C"
		kde_src_compile configure
		kde_src_compile make
	done
}

src_install() {
	for dir in `ls ${WORKDIR}`; do
		cd ${WORKDIR}/$dir
		make install DESTDIR=${D} destdir=${D}
	done
}

