# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zthread/zthread-2.3.2-r1.ebuild,v 1.1 2009/04/19 20:00:34 halcy0n Exp $

inherit flag-o-matic eutils

MY_P="ZThread-${PV}"

DESCRIPTION="A platform-independent multi-threading and synchronization library for C++"
HOMEPAGE="http://zthread.sourceforge.net/"
SRC_URI="mirror://sourceforge/zthread/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="debug doc kernel_linux"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-fpermissive.diff
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable kernel_linux atomic-linux) \
		|| die "configure failed"
	emake || die "make failed"

	if use doc ; then
		doxygen doc/zthread.doxygen || die "generating docs failed"
		cp ./doc/documentation.html ./doc/html/index.html
		cp ./doc/zthread.css ./doc/html/zthread.css
		cp ./doc/bugs.js ./doc/html/bugs.js;
	fi
}

src_install() {
	# Uses it's own install-hooks and ignores DESTDIR
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog README NEWS TODO
	use doc && dohtml doc/html/*
}
