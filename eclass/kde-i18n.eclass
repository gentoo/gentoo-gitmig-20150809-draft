# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-i18n.eclass,v 1.45 2003/07/13 09:08:26 danarmak Exp $
#
# Author Dan Armak <danarmak@gentoo.org>

inherit kde
ECLASS=kde-i18n
INHERITED="$INHERITED $ECLASS"

S=${WORKDIR}/${PN}
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

SLOT="$KDEMAJORVER.$KDEMINORVER"

need-kde ${PV}

# RPV and RP for Real P and PV
case "$PV" in
	3.1_beta1)	RPV=3.0.7;;
	3.1_beta2)	RPV=3.0.8;;
	3.1_rc1)	RPV=3.0.9;;
	3.1_rc2)	RPV=3.0.98;;
	3.1_rc5)	RPV=3.1rc5;;
	3.1_rc6)	RPV=3.1rc6;;
	*)		RPV=$PV;;
esac
RP="$PN-$RPV"

case "$PV" in
	2.2.2)		SRC_PATH="${PV}/src/${P}.tar.bz2"
			KEYWORDS="x86";;
	3.1_*)		SRC_PATH="unstable/kde-${PV//_/-}/src/kde-i18n/${RP}.tar.bz2" 
			KEYWORDS="~x86 ~ppc";;
	3.0.5a)		SRC_PATH="stable/${PV}/src/kde-i18n/${PN}-${PV/a/}.tar.bz2" 
			KEYWORDS="x86 ppc";;
	3*)		SRC_PATH="stable/${PV}/src/kde-i18n/${P}.tar.bz2" 
			KEYWORDS="x86 ppc";;
	5)		KEYWORDS="x86";;
esac

if [ "$PV" == "5" ]; then
	S=${WORKDIR}/kde-i18n
elif [ "$PN" == "kde-i18n" ]; then
	SRC_PATH=${SRC_PATH/src\/kde-i18n\//src\//}
	S=${WORKDIR}/${RP}
fi

# for cvs ebuilds we don't need to fetch tarballs
if [ "$PV" != "5" ]; then
	SRC_URI="$SRC_URI mirror://kde/$SRC_PATH"
fi

kde-i18n_src_unpack() {
	
	if [ "$PV" == "5" ]; then
	    KCVS_MODULE=kde-i18n
	    [ "$PN" != "kde-i18n" ] && KCVS_SUBDIR="${PN//kde-i18n-}"
	    KCVS_SUBDIR_NODOC=true
	    kde-source_src_unpack
	else
	    base_src_unpack
	fi

	for dir in ${S} `cat ${S}/subdirs`; do
		if [ -f "$dir/docs/common/Makefile.in" ]; then
			# this enables destdir!=kdelibsdir
			cd $dir/docs/common
			cp Makefile.in Makefile.in.orig
			sed -e 's:(kde_htmldir)/en/common:(kde_libs_htmldir)/en/common:g' Makefile.in.orig > Makefile.in
		fi
	done
	
	if [ "$PV" == "5" -a "$PN" != "kde-i18n" ]; then
	    cd $S
	    echo ${PN//kde-i18n-/} > subdirs
	fi
	
}

kde-i18n_src_compile() {

	kde_src_compile myconf
	myconf="$myconf --prefix=$KDEDIR"
	
	# enable caching because that makes running all the configure scripts in the subdirs faster
	# (for cvs i18n packages)
	myconf="$myconf -C"
	
	kde_src_compile configure
	
	# wierd, but this is apparently equired by what's in kde i18n cvs nowadays
	if [ "$PV" == "5" ]; then
	    for x in `cat subdirs`; do
		cd $S/$x
	        test -f ./configure && ( ./configure --cache-file=../config.cache $myconf || die "configure failed" )
	    done
	fi
	
	cd $S
	kde_src_compile make

}

EXPORT_FUNCTIONS src_unpack src_compile

