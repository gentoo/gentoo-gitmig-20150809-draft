# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-frontends/sane-frontends-1.0.11.ebuild,v 1.9 2004/07/31 02:54:56 tgall Exp $

DESCRIPTION="Scanner Access Now Easy"
HOMEPAGE="http://www.sane-project.org"
SRC_URI="ftp://ftp.mostang.com/pub/sane/${P}/${P}.tar.gz
		ftp://ftp.mostang.com/pub/sane/old-versions/${P}/${P}.tar.gz"

DEPEND=">=media-gfx/sane-backends-${PV}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ppc64"
IUSE=""

src_compile() {
	econf \
		--datadir=/usr/share/misc || die
	emake || die "emake failed"
}

src_install() {
	einstall datadir=${D}/usr/share/misc || die

	dodir /usr/lib/gimp/1.2/plug-ins
	dosym /usr/bin/xscanimage /usr/lib/gimp/1.2/plug-ins/xscanimage
	dodoc AUTHORS COPYING Changelog NEWS PROBLEMS README TODO
}
