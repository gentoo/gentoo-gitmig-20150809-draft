# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ocfs-tools/ocfs-tools-1.1.2.ebuild,v 1.1 2005/03/10 15:21:49 xmerlin Exp $

inherit flag-o-matic eutils

DESCRIPTION="Support programs for the Oracle Cluster Filesystem v1 and v2"
HOMEPAGE="http://oss.oracle.com/projects/ocfs/"
SRC_URI="http://oss.oracle.com/projects/ocfs-tools/dist/files/source/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="-* ~x86"
IUSE="gtk"

DEPEND="virtual/libc
	sys-kernel/linux-headers
	gtk? (
		>=dev-libs/glib-2.4.0
		>=x11-libs/gtk+-1.2.8
	)"

RDEPEND="virtual/libc
	gtk? (
		>=dev-libs/glib-2.4.0
		>=x11-libs/gtk+-1.2.8
	)"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	# glib patch (if you build ocfs-tools without X apps)
	epatch ${FILESDIR}/ocfs-tools-glib.patch || die "glib patch did not apply"
}

src_compile() {
	local myconf=""
	use gtk && myconf="${myconf} --enable-ocfstool=yes" || \
		myconf="${myconf} --enable-ocfstool=no --disable-gtktest"

	econf --prefix=/ \
		${myconf} \
		|| die "Failed to configure"

	emake -j1 || die "Failed to compile"
}

src_install() {
	einstall || die "Failed to install"

	## NEED TO BE FIXED -> it lacks a proper init

	doman format/mkfs.ocfs.8
	dodoc COPYING README debugocfs/debugocfs.txt bugfix/bug*-README.txt
}
