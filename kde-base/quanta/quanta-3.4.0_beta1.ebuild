# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/quanta/quanta-3.4.0_beta1.ebuild,v 1.2 2005/01/16 17:21:07 greg_g Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: Quanta Plus Web Development Environment"
KEYWORDS="~x86"
IUSE="doc tidy"
DEPEND="doc? ( app-doc/quanta-docs )
	dev-libs/libxml2"
RDEPEND="$DEPEND
$(deprange-dual $PV $MAXKDEVER kde-base/kfilereplace)
$(deprange-dual $PV $MAXKDEVER kde-base/kimagemapeditor)
$(deprange-dual $PV $MAXKDEVER kde-base/klinkstatus)
$(deprange-dual $PV $MAXKDEVER kde-base/kommander)
$(deprange-dual $PV $MAXKDEVER kde-base/kxsldbg)
tidy? ( app-text/htmltidy )
!app-editors/quanta"
myconf="--with-extra-includes=$(xml2-config --cflags | sed -e 's:^-I::')"

KMCOMPILEONLY=lib

# TODO: check why this wasn't needed back in the monolithic ebuild
src_compile () {
	export LIBXML_LIBS="`xml2-config --libs`"
	export LIBXSLT_LIBS="`xslt-config --libs`"
	kde-meta_src_compile
}

