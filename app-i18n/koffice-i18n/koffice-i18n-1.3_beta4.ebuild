# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/koffice-i18n/koffice-i18n-1.3_beta4.ebuild,v 1.1 2003/09/25 19:49:14 caleb Exp $

inherit kde
need-kde 3

MY_PV=1.2.93
MY_P=${PN}-${MY_PV}

DESCRIPTION="KOffice i18n files"
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"
KEYWORDS="~x86"
RESTRICT="nomirror"
DEPEND="~app-office/koffice-${PV}"

LANGS="af bg ca cs cy da de el en_GB eo es et fa fr he hu it
ja nb nl nn pl pt pt_BR ru se sk sl sr sv tr ven xh zh_CN zh_TW"

BASEDIR="mirror://kde/unstable/koffice-${MY_PV}/src/"

#Maybe this isn't the smartest way of doing things, but it works
#for the purposes of this ebuild.
USE="${USE} ${LINGUAS}"

# Important:
#
# If you start the emerge without setting the LINGUAS variable, then try to
# reemerge, portage will NOT scan your changes, because the ebuild itself
# hasn't changed.  You need to "touch" this ebuild file to make portage re-evaluate
# this ebuild after your LINGUAS changes.

if [ -z "${LINGUAS}" ]; then
	ewarn "Using the LINGUAS environment variable, you can download only"
	ewarn "language packages you are interested in.  Currently you are"
	ewarn "downloading all languages available."

	SRC_URI="$BASEDIR/koffice-i18n-${MY_PV}.tar.bz2"
else
	for pkg in $LANGS
	do
		if [ `use ${pkg}` ] ; then
			SRC_URI="$SRC_URI $BASEDIR/koffice-i18n-${pkg}-${MY_PV}.tar.bz2"
			echo "using package ${pkg}"
		fi
	done
fi

src_unpack() {
	base_src_unpack unpack
}

src_compile() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		S=${WORKDIR}/$dir
		kde_src_compile myconf
		myconf="$myconf --prefix=$KDEDIR -C"
		kde_src_compile configure
		kde_src_compile make
	done
	S=${_S}
}

src_install() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		cd ${WORKDIR}/$dir
		make install DESTDIR=${D} destdir=${D}
	done
	S=${_S}
}

