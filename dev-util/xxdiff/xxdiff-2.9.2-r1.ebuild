# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/xxdiff-2.9.2-r1.ebuild,v 1.7 2004/04/03 12:29:14 plasmaroo Exp $

DESCRIPTION="A graphical file and directories comparator and merge tool."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://xxdiff.sourceforge.net/"

DEPEND=">=x11-libs/qt-3.0.0
	=dev-util/tmake-1.8*
	kde? ( >=kde-base/kdelibs-3.1.0 )"

RDEPEND="${DEPEND}
	sys-apps/diffutils"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
IUSE="kde"

src_unpack()
{
	unpack ${A}
	if [ `use kde` ]; then
		cd ${S}/src
		cp ${FILESDIR}/kdesupport.patch .
		sed -e "s:/usr/kde/3.1:`ls -d /usr/kde/* | tail -n 1`:g" -i kdesupport.patch
		epatch kdesupport.patch
	fi
}

src_compile() {
	cd src
	tmake -o Makefile xxdiff.pro

	REALHOME="$HOME"
	mkdir -p $T/fakehome/.kde
	mkdir -p $T/fakehome/.qt
	export HOME="$T/fakehome"
	addwrite "${QTDIR}/etc/settings"

	# things that should access the real homedir
	[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"

	emake || die
}

src_install () {
	dobin src/xxdiff
	doman src/xxdiff.1
	dodoc README COPYING CHANGES TODO
	dodoc copyright.txt
}
