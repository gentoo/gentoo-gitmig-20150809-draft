# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-themes/ksplash-ml-themes/ksplash-ml-themes-20020705.ebuild,v 1.5 2002/08/13 20:16:50 gerk Exp $
inherit kde-functions

set-kdedir 3

HOMEPAGE="http://www.shadowcom.net/Software/ksplash-ml/"
DESCRIPTION="Extra theme packagse for ksplash-ml"

SLOT="3"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

newdepend "x11-misc/ksplash-ml"

THEMES="ExtraThemes DeLorean Viper Crystal xpAnime Landskape costello"
for x in $THEMES; do
    SRC_URI="$SRC_URI http://www.shadowcom.net/Software/ksplash-ml/${x}.tgz"
done

theme-ksplash_src_compile() { true; }

src_install() {

    dodir ${KDEDIR}/share/apps/ksplashml/Themes/
    cp -r ${WORKDIR}/* ${D}/${KDEDIR}/share/apps/ksplashml/Themes/

}



