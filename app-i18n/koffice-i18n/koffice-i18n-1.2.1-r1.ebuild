# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/koffice-i18n/koffice-i18n-1.2.1-r1.ebuild,v 1.3 2004/01/24 04:01:00 vapier Exp $

inherit kde
need-kde 3

MY_PV=${PV}
MY_P=${PN}-${MY_PV}

DESCRIPTION="KOffice i18n files"
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"
KEYWORDS="x86"
RESTRICT="nomirror"
DEPEND="~app-office/koffice-${PV}"

LANGS="af ar bs ca cs da de el en_GB eo es et fr he hu it
ja lt lv mt nb nl nn pl pt pt_BR ru sk sl sv th tr uk ven xh zh_TW zu"

BASEDIR="mirror://kde/stable/koffice-${MY_PV}/src/"

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

