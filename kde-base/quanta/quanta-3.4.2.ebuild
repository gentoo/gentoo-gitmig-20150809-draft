# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/quanta/quanta-3.4.2.ebuild,v 1.3 2005/08/08 21:37:39 kloeri Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Quanta Plus Web Development Environment"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc tidy"
DEPEND="dev-libs/libxslt
	dev-libs/libxml2"
RDEPEND="$DEPEND
$(deprange $PV $MAXKDEVER kde-base/kfilereplace)
$(deprange $PV $MAXKDEVER kde-base/kimagemapeditor)
$(deprange $PV $MAXKDEVER kde-base/klinkstatus)
$(deprange $PV $MAXKDEVER kde-base/kommander)
$(deprange 3.4.1 $MAXKDEVER kde-base/kxsldbg)
tidy? ( app-text/htmltidy )
doc? ( app-doc/quanta-docs )"

KMCOMPILEONLY=lib

# TODO: check why this wasn't needed back in the monolithic ebuild
src_compile () {
	myconf="--with-extra-includes=$(xml2-config --cflags | sed -e 's:^-I::')"

	export LIBXML_LIBS="`xml2-config --libs`"
	export LIBXSLT_LIBS="`xslt-config --libs`"
	kde-meta_src_compile
}
