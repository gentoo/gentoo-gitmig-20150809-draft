# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acl/acl-2.2.27.ebuild,v 1.5 2004/11/12 20:14:13 gustavoz Exp $

inherit eutils

DESCRIPTION="Access control list utilities, libraries and headers"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sh sparc x86"
IUSE="nls debug"

RDEPEND=">=sys-apps/attr-2.4
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^PKG_DOC_DIR/s:=.*:= /usr/share/doc/${PF}:" \
		-e '/^PKG_[[:upper:]]*_DIR/s:= := $(DESTDIR):' \
		include/builddefs.in \
		|| die "failed to update builddefs"
}

src_compile() {
	if use debug ; then
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
		--mandir=/usr/share/man \
		--prefix=/usr \
		--libexecdir=/usr/$(get_libdir) \
		--libdir=/$(get_libdir) \
		--bindir=/bin \
		$(use_enable nls gettext) \
		|| die
	emake || die
}

src_install() {
	make DIST_ROOT=${D} install install-dev install-lib || die
}
