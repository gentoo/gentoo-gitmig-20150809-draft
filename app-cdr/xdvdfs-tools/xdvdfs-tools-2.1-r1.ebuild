# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xdvdfs-tools/xdvdfs-tools-2.1-r1.ebuild,v 1.2 2008/06/14 16:13:13 drac Exp $

inherit eutils

DESCRIPTION="Tools for manipulating Xbox ISO images"
HOMEPAGE="http://www.layouts.xbox-scene.com/"
SRC_URI="http://www.layouts.xbox-scene.com/main/files/XDVDFSToolsv2.1.rar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="app-arch/unrar"
RDEPEND=""

S=${WORKDIR}/XDVDFS_Tools/src

src_unpack() {
	unrar x "${DISTDIR}"/XDVDFSToolsv${PV}.rar
	mv "XDVDFS Tools" XDVDFS_Tools
	sed -i -e "s:CCFLAGS = .*:CCFLAGS = ${CFLAGS}:g" "${S}"/makefile.prefab
	epatch "${FILESDIR}"/${P}-fnamefix.patch
	mkdir "${S}"/xdvdfs_extract/output "${S}"/xdvdfs_maker/output
}

src_compile() {
	cd "${S}"/xdvdfs_dumper
	emake || die "xdvdfs_dumper"
	cd ../xdvdfs_extract
	emake || die "xdvdfs_extract"
	cd ../xdvdfs_maker
	emake || die "xdvdfs_maker"
}

src_install() {
	dobin xdvdfs_dumper/output/xdvdfs_dumper || die "xdvdfs_dumper"
	dobin xdvdfs_extract/output/xdvdfs_extract || die "xdvdfs_extract"
	dobin xdvdfs_maker/output/xdvdfs_maker || die "xdvdfs_maker"
	dohtml ../documentation/*.htm
	dodoc ../Readme.txt
}
