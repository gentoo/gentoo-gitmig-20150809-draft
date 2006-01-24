# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcube/wmcube-0.98.ebuild,v 1.12 2006/01/24 22:58:11 nelchael Exp $

DESCRIPTION="a dockapp cpu monitor with spinning 3d objects"
HOMEPAGE="http://kling.mine.nu/kling/wmcube.htm"
SRC_URI="http://kling.mine.nu/kling/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~mips ppc ppc64 ~sparc"

IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

S="${WORKDIR}/${P}/wmcube"

src_compile() {

	emake || die "parallel make failed"

}

src_install() {
	dobin wmcube

	cd ..
	dodoc README CHANGES

	SHARE=${DESTTREE}/share/wmcube
	dodir ${SHARE}
	insinto ${SHARE}
	doins 3dObjects/*
}
