# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/conectiva-crystal/conectiva-crystal-3.1_beta37-r1.ebuild,v 1.1 2002/07/29 14:38:58 danarmak Exp $
inherit kde # not kde-base since we don't need c++ deps

need-kde 3

S="${WORKDIR}/Crystal"
DESCRIPTION="Conectiva Crystal - Icon theme. WARNING: already included in >=kde-3.1."
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/crystal-3.1_beta3.7.tar.gz"
HOMEPAGE="http://www.conectiva.com.br"
KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_compile() {

	return 1
}

src_install(){

	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons/Crystal

}
