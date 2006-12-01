# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/quanta/quanta-3.5.2.ebuild,v 1.12 2006/12/01 20:08:45 flameeyes Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Quanta Plus Web Development Environment"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="doc kdehiddenvisibility tidy"
DEPEND="dev-libs/libxslt
	dev-libs/libxml2"
RDEPEND="${RDEPEND}
$(deprange $PV $MAXKDEVER kde-base/kfilereplace)
$(deprange $PV $MAXKDEVER kde-base/kimagemapeditor)
$(deprange $PV $MAXKDEVER kde-base/klinkstatus)
$(deprange $PV $MAXKDEVER kde-base/kommander)
$(deprange $PV $MAXKDEVER kde-base/kxsldbg)
tidy? ( app-text/htmltidy )
doc? ( app-doc/quanta-docs )"

KMCOMPILEONLY=lib

# TODO: check why this wasn't needed back in the monolithic ebuild
src_compile () {
	myconf="--with-extra-includes=$(xml2-config --cflags | sed -e 's:^-I::')"
	kde-meta_src_compile
}
