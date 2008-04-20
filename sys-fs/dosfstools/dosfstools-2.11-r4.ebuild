# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dosfstools/dosfstools-2.11-r4.ebuild,v 1.1 2008/04/20 19:00:23 vapier Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^PREFIX/s:=:=/usr:' \
		-e '/^MANDIR/s:/usr:/share:' \
		Makefile || die "sed Makefile"
	epatch "${FILESDIR}"/dosfstools-2.11-fat32size.patch
	epatch "${FILESDIR}"/dosfstools-2.11-verify-double-count-fix.patch
	epatch "${FILESDIR}"/dosfstools-2.11-build.patch
	epatch "${FILESDIR}"/dosfstools-2.11-preen.patch
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	emake PREFIX="${D}"/usr install || die
	dodir /sbin
	mv "${D}"/usr/sbin/*fsck* "${D}"/sbin/ || die

	dodoc CHANGES TODO
	newdoc dosfsck/README README.dosfsck
	newdoc dosfsck/CHANGES CHANGES.dosfsck
	newdoc mkdosfs/README README.mkdosfs
	newdoc mkdosfs/ChangeLog ChangeLog.mkdosfs
}
