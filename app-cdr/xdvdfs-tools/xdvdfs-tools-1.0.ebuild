# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xdvdfs-tools/xdvdfs-tools-1.0.ebuild,v 1.5 2004/10/16 14:53:45 chrb Exp $

DESCRIPTION="Tools for manipulating Xbox ISO images"
HOMEPAGE="http://xbox-scene.org"

# the filename actually has a space in it, so either get this from the gentoo mirror,
# or get it manually
SRC_URI="http://dwl.xbox-scene.com/~xbox/xbox-scene/tools/isotools/XDVDFS_Tools.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc ~amd64"
DEPEND=""
S=${WORKDIR}/"XDVDFS_Tools/src"

src_unpack() {
	unpack ${A}
	mv "XDVDFS Tools" XDVDFS_Tools
	sed -i -e "s:CCFLAGS = .*:CCFLAGS = ${CFLAGS}:g" "${S}"/makefile.prefab
}

src_compile() {
	cd xdvdfs_dumper
	emake || die
	cd ../xdvdfs_extract
	emake || die
	cd ../xdvdfs_maker
	emake || die
}

src_install() {
	dobin ${S}/xdvdfs_dumper/output/xdvdfs_dumper
	dobin ${S}/xdvdfs_extract/output/xdvdfs_extract
	dobin ${S}/xdvdfs_maker/output/xdvdfs_maker
	dodoc ${S}/../documentation.pdf
}
