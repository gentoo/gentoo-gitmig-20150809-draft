# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/udis86/udis86-1.7.ebuild,v 1.4 2010/05/10 12:55:20 chithanh Exp $

DESCRIPTION="Disassembler library for the x86/-64 architecture sets."
HOMEPAGE="http://udis86.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE=""

DEPEND="test? ( dev-lang/yasm )"
RDEPEND=""

# src_test() needs dev-lang/yasm which is not keyworded on all arches, bug #318805.
RESTRICT="!amd64? ( !x86? ( !x86-fbsd? ( test ) ) )"

src_install() {
	emake docdir="/usr/share/doc/${PF}/" DESTDIR="${D}" install || die "emake install failed"
}
