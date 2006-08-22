# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/paludis/paludis-0.4.4.ebuild,v 1.1 2006/08/22 21:24:09 ferdy Exp $

DESCRIPTION="paludis, the other package mangler"
HOMEPAGE="http://paludis.berlios.de/"
SRC_URI="http://download.berlios.de/paludis/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~sparc ~x86"
IUSE="doc pink selinux"

DEPEND="
	dev-cpp/libebt
	>=app-shells/bash-3
	doc? ( app-doc/doxygen )
	selinux? ( sys-libs/libselinux )"

RDEPEND="
	>=app-admin/eselect-1.0.2
	>=app-shells/bash-3
	net-misc/wget
	net-misc/rsync
	!mips? ( sys-apps/sandbox )
	selinux? ( sys-libs/libselinux )"

PROVIDE="virtual/portage"

src_compile() {
	econf --disable-qa \
		$(use_enable doc doxygen ) \
		$(use_enable !mips sandbox ) \
		$(use_enable pink) \
		$(use_enable selinux) \
		|| die "econf failed"

	emake || die "emake failed"
	if use doc ; then
		make doxygen || die "make doxygen failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README ChangeLog NEWS

	if use doc ; then
		dohtml -r doc/html/
	fi
}

src_test() {
	# Work around Portage bug
	addwrite /var/cache
	emake check || die "Make check failed"
}

