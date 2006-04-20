# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmapi/dmapi-2.2.3.ebuild,v 1.2 2006/04/20 01:41:55 vapier Exp $

inherit eutils

DESCRIPTION="XFS data management API library"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-fs/xfsprogs"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.2.1-only-symlink-when-needed.patch
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch #126825
	sed -i \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		include/builddefs.in \
		|| die "failed to update builddefs"
}

src_compile() {
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	econf --libexecdir=/usr/$(get_libdir) || die
	emake || die
}

src_install() {
	make DIST_ROOT="${D}" install install-dev || die
	prepalldocs

	# move shared libs to /
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/libdm.so* "${D}"/$(get_libdir)/ || die
	gen_usr_ldscript libdm.so
}
