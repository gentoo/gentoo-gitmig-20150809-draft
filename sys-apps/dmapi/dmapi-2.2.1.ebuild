# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmapi/dmapi-2.2.1.ebuild,v 1.7 2005/07/11 00:50:35 agriffis Exp $

inherit eutils

DESCRIPTION="XFS data management API library"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc ~sparc x86"
IUSE="debug"

DEPEND="sys-fs/xfsprogs"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		-e 's:^PKG_\(.*\)_DIR[[:space:]]*= \(.*\)$:PKG_\1_DIR = $(DESTDIR)\2:' \
		include/builddefs.in || die
}

src_compile() {
	use debug \
		&& export DEBUG=-DDEBUG \
		|| export DEBUG=-DNDEBUG
	export OPTIMIZER="${CFLAGS}"

	# Some archs need the PLATFORM var unset
	unset PLATFORM

	econf \
		--libdir=/$(get_libdir) \
		--libexecdir=/usr/$(get_libdir) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install install-dev || die
}
