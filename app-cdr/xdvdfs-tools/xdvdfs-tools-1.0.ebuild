# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xdvdfs-tools/xdvdfs-tools-1.0.ebuild,v 1.6 2004/10/26 13:18:36 vapier Exp $

DESCRIPTION="Tools for manipulating Xbox ISO images"
HOMEPAGE="http://xbox-scene.org/"
SRC_URI="http://dwl.xbox-scene.com/~xbox/xbox-scene/tools/isotools/XDVDFS_Tools.tar.bz2"
# the filename actually has a space in it, so either
# get this from the gentoo mirror, or get it manually

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/"XDVDFS_Tools/src"

src_unpack() {
	unpack ${A}
	mv "XDVDFS Tools" XDVDFS_Tools
	sed -i -e "s:CCFLAGS = .*:CCFLAGS = ${CFLAGS}:g" "${S}"/makefile.prefab
}

src_compile() {
	cd xdvdfs_dumper
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
	dodoc ../documentation.pdf
}
