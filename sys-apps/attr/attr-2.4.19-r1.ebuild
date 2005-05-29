# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.4.19-r1.ebuild,v 1.2 2005/05/29 09:24:49 vapier Exp $

inherit eutils

DESCRIPTION="Extended attributes tools"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz
	ftp://xfs.org/mirror/SGI/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="nls debug"

DEPEND=">=sys-apps/portage-2.0.47-r10
	nls? ( sys-devel/gettext )
	sys-devel/libtool"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		include/builddefs.in \
		|| die "failed to update builddefs"

	epatch "${FILESDIR}"/${P}-attr_copy_file-suppress-warning.patch #93348
	# More extensive man 2 documentation is found in the man-pages package,
	# so disable the installation of them
	epatch "${FILESDIR}"/${PN}-no-man2pages.patch
}

src_compile() {
	if use debug ; then
		export DEBUG=-DDEBUG
	else
		export DEBUG=-DNDEBUG
	fi
	export OPTIMIZER="${CFLAGS}"

	econf \
		$(use_enable nls gettext) \
		--libdir=/$(get_libdir) \
		--libexecdir=/usr/$(get_libdir) \
		--bindir=/bin \
		|| die
	emake || die
}

src_install() {
	make DIST_ROOT="${D}" install install-lib install-dev || die
	prepalldocs
}
