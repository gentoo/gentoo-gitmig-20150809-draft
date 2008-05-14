# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ktoblzcheck/ktoblzcheck-1.14.ebuild,v 1.9 2008/05/14 09:38:21 hanno Exp $

DESCRIPTION="Library to check account numbers and bank codes of German banks"
HOMEPAGE="http://ktoblzcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="python"

RDEPEND="sys-apps/gawk
	sys-apps/grep
	python? ( || ( dev-python/ctypes >=dev-lang/python-2.5 ) )"
DEPEND="${RDEPEND}
	sys-devel/libtool"

src_compile() {
	econf `use_enable python` || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall BANKDATA_PATH="${D}/usr/share/ktoblzcheck" || die "install failed"
}
