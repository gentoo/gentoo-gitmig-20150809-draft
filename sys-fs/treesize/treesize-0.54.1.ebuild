# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/treesize/treesize-0.54.1.ebuild,v 1.2 2010/06/26 22:21:08 angelos Exp $

EAPI="2"

inherit base

DESCRIPTION="A disk consumption analyzing tool"
HOMEPAGE="http://treesize.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PV}-amd64.patch" )

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	dodoc NEWS README TODO ChangeLog || die "nothing to read"
}
