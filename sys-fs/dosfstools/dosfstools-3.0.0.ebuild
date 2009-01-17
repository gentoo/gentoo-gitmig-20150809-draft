# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dosfstools/dosfstools-3.0.0.ebuild,v 1.8 2009/01/17 15:11:13 bluebird Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="http://www.daniel-baumann.ch/software/dosfstools/"
SRC_URI="http://www.daniel-baumann.ch/software/dosfstools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""
RESTRICT="test" # there is no test target #239071

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^PREFIX/s:/local::' \
		-e '/^OPTFLAGS/s:=.*:=:' \
		Makefile || die "sed Makefile"
	append-lfs-flags
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodir /sbin
	mv "${D}"/usr/sbin/*fsck* "${D}"/sbin/ || die
	mv "${D}"/usr/share/doc/{${PN},${PF}} || die
	prepalldocs
}
