# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/koffice-i18n/koffice-i18n-1.3.ebuild,v 1.3 2004/02/09 09:26:31 dholm Exp $

inherit kde
need-kde 3

DESCRIPTION="KOffice i18n files"
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
RESTRICT="nomirror"
newdepend "~app-office/koffice-${PV} >=sys-apps/portage-2.0.49-r8"

LANGS="af bg ca cs da de el en_GB eo es et fa fi fr he hu it ja lo
mt nb nl nn pl pt pt_BR ru se sk sl sr sv th tr ven xh zh_CN zh_TW zu"

BASEDIR="mirror://kde/stable/koffice-${PV}/src/"

# Define the LINGUAS environment variable to contain which langauge(s) you
# would like for this ebuild to download and install

for pkg in $LANGS
do
	SRC_URI="$SRC_URI linguas_${pkg}? ( $BASEDIR/koffice-i18n-${pkg}-${PV}.tar.bz2)"
done

if [ -z "$SRC_URI" ]; then
	SRC_URI="$BASEDIR/koffice-i18n-${PV}.tar.bz2"
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

