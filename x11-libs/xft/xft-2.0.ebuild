# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xft/xft-2.0.ebuild,v 1.1 2002/10/27 15:19:16 foser Exp $

PROVIDE="virtual/xft"
DESCRIPTION="Xft2"
SRC_URI="http://fontconfig.org/release/fcpackage.${PV/\./_}.tar.gz"     
HOMEPAGE="http://fontconfig.org/" 
LICENSE="fontconfig"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="x11-base/xfree"
S="${WORKDIR}/fcpackage.${PV/\./_}/Xft"   

src_compile() {
	econf || die "Xft2 config failed"
	emake || die "Xft2 make failed"  
}

src_install() {
	einstall confdir=${D}/etc/fonts \
		datadir=${D}/usr/share || die    
}
