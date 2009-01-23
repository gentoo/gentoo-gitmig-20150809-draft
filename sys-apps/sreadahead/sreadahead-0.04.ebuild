# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sreadahead/sreadahead-0.04.ebuild,v 1.1 2009/01/23 05:57:56 darkside Exp $

EAPI=2

DESCRIPTION="A readahead implementation optimized for solid state discs"
HOMEPAGE="http://code.google.com/p/sreadahead/"
SRC_URI="http://sreadahead.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README 0001-superreadahead-patch.patch || die
	newinitd "${FILESDIR}"/sreadahead.rc sreadahead || die
	newinitd "${FILESDIR}"/sreadahead-pack.rc sreadahead-pack || die
}

pkg_postinst() {
	elog "Sreadahead requires a kernel built with the superreadahead patch,"
	elog "which can be found in /usr/share/doc/${PF}"
	elog "If you don't know how to do this, it may be best to stay away from it"
	elog
	elog "Note that only ext3 partitions are currently supported."
	elog
	elog "To add sreadahead to your runlevels:"
	elog "  # rc-update add sreadahead boot"
	elog "  # rc-update add sreadahead-pack default"
}
