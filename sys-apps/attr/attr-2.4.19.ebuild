# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.4.19.ebuild,v 1.3 2004/11/12 15:32:48 vapier Exp $

inherit eutils

DESCRIPTION="Extended attributes tools"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sh ~sparc x86"
IUSE="nls debug"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5
	virtual/libc
	nls? ( sys-devel/gettext )
	sys-devel/libtool"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		-e '/^PKG_[[:upper:]]*_DIR/s:= := $(DESTDIR):' \
		include/builddefs.in \
		|| die "failed to update builddefs"

	# More extensive man 2 documentation is found in the man-pages package,
	# so disable the installation of them
	epatch ${FILESDIR}/${PN}-no-man2pages.patch
}

src_compile() {
	if use debug; then
		export DEBUG=-DDEBUG
	else
		export DEBUG=-DNDEBUG
	fi
	export OPTIMIZER="${CFLAGS}"

	# Some archs need the PLATFORM var unset
	if hasq ${ARCH} mips ppc sparc ppc64 s390; then
		unset PLATFORM
	fi

	econf \
		$(use_enable nls gettext) \
		--libdir=/$(get_libdir) \
		--libexecdir=/usr/$(get_libdir) \
		--bindir=/bin \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install install-lib install-dev || die
}
