# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acl/acl-2.2.13-r3.ebuild,v 1.4 2004/11/15 01:01:21 vapier Exp $

inherit eutils

DESCRIPTION="Access control list utilities, libraries and headers"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sparc x86"
IUSE="nls debug"

RDEPEND=">=sys-apps/attr-2.4
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_compile() {
	if use debug; then
		DEBUG=-DDEBUG
		OPTIMIZER="-g"
		CFLAGS=
		CXXFLAGS=
		export CFLAGS CXXFLAGS
	else
		DEBUG=-DNDEBUG
		OPTIMIZER="${CFLAGS}"
	fi
	export DEBUG OPTIMIZER

	# Some archs need the PLATFORM var unset
	if hasq ${ARCH} mips ppc sparc ppc64 s390; then
		unset PLATFORM
	fi

	autoconf || die

	local mylibdir="`get_libdir`"
	econf \
		`use_enable nls gettext` \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--libexecdir=/usr/${mylibdir} \
		--libdir=/${mylibdir} \
		--bindir=/bin \
		|| die

	sed -i \
		-e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e 's:-O1::' \
		include/builddefs || die "failed to update builddefs"

	emake || die
}

src_install() {
	make DIST_ROOT=${D} install install-dev install-lib || die
}
