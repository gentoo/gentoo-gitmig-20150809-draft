# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/parallel/parallel-20101202.ebuild,v 1.2 2010/12/21 11:10:15 fauli Exp $

EAPI=3

DESCRIPTION="A shell tool for executing jobs in parallel locally or on remote machines"
HOMEPAGE="http://www.gnu.org/software/parallel/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/perl"
# Collision, reported upstream, see bug 349225
DEPEND="${RDEPEND}
	!sys-apps/moreutils"

src_install() {
	emake install DESTDIR="${D}" docdir=/usr/share/doc/${PF}/html \
		|| die
	dodoc NEWS README || die
}
