# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sreadahead/sreadahead-1.0-r1.ebuild,v 1.1 2009/03/28 03:13:02 darkside Exp $

inherit eutils

DESCRIPTION="A readahead implementation optimized for solid state disks"
HOMEPAGE="http://code.google.com/p/sreadahead/"
SRC_URI="http://sreadahead.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/sreadahead_iter_ctrl.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README "${FILESDIR}/0001-kernel-trace-open.patch" || die
	newinitd "${FILESDIR}"/sreadahead.rc sreadahead || die
	keepdir "/var/lib/sreadahead/debugfs" || die "dodir failed"
}

pkg_postinst() {
	elog "Sreadahead requires a kernel built with the trace-open patch,"
	elog "which can be found in /usr/share/doc/${PF}"
	elog "If you don't know how to do this, it may be best to stay away from it"
	elog
	elog "To add sreadahead to your runlevels:"
	elog "  # rc-update add sreadahead boot"
}
