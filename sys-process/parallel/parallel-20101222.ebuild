# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/parallel/parallel-20101222.ebuild,v 1.1 2010/12/24 06:25:48 fauli Exp $

EAPI=3

DESCRIPTION="A shell tool for executing jobs in parallel locally or on remote machines"
HOMEPAGE="http://www.gnu.org/software/parallel/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/perl"
# File collision
DEPEND="${RDEPEND}
	!sys-apps/moreutils"

src_install() {
	emake install DESTDIR="${D}" docdir=/usr/share/doc/${PF}/html \
		|| die
	dodoc NEWS README || die
}

pkg_postinst() {
	elog "To distribute jobs to remote machines you'll need these dependencies:"
	echo
	elog "  net-misc/openssh"
	elog "  net-misc/rsync"
}
