# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/squashfs-tools/squashfs-tools-1.3.ebuild,v 1.1 2004/02/15 02:16:15 brad_mssw Exp $

DESCRIPTION="Tool for creating compressed filesystem type squashfs"
PNAME="squashfs1.3r3"
SRC_URI="mirror://sourceforge/squashfs/${PNAME}.tar.gz"
HOMEPAGE="http://squashfs.sourceforge.net/"
IUSE=""
KEYWORDS="x86 amd64 ~ppc ~ppc64 ~alpha ~ia64 ~sparc ~mips ~hppa"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
S="${WORKDIR}/${PNAME}"
DOC="${S}"
S="${S}/squashfs-tools"

src_compile() {
	cd ${S}
	make || die
}

src_install() {
	cd ${S}
	exeinto /usr/bin
	doexe mksquashfs
	cd ${DOC}
	dodoc README
}

