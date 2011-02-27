# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libexplain/libexplain-0.40.ebuild,v 1.5 2011/02/27 09:24:28 xarthisius Exp $

EAPI="3"

MY_P="${P}.D001"

DESCRIPTION="Library which may be used to explain Unix and Linux system call errors"
HOMEPAGE="http://libexplain.sourceforge.net/"
#SRC_URI="http://libexplain.sourceforge.net/${MY_P}.tar.gz"
SRC_URI="mirror://sourceforge/project/${PN}/${PV}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-3"
IUSE=""

S="${WORKDIR}"/${MY_P}

src_prepare() {
	# Portage incompatible test
	sed \
		-e '/t0524a/d' \
		-e '/t0363a/d' \
		-i Makefile.in || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc README || die
}
