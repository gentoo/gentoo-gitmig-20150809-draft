# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/conectiva-crystal/conectiva-crystal-021209.ebuild,v 1.2 2003/02/03 10:37:00 pvdabeel Exp $
inherit kde # not kde-base since we don't need c++ deps

need-kde 3

S="${WORKDIR}/crystal"
DESCRIPTION="Conectiva Crystal - Icon theme. WARNING: already included in >=kde-3.1."
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="http://www.conectiva.com.br"
KEYWORDS="x86 alpha ~ppc"
SLOT="0"
LICENSE="as-is"

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_compile() {

	cd ${S}
	sed "s/Name=Conectiva Crystal .*/Name=Conectiva Crystal Snapshot ${PV}/" index.desktop > index.temp
	mv index.temp index.desktop
	return 1
}

src_install(){

	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons/Crystal-${PV}

}
