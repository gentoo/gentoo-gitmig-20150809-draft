# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.5.9.ebuild,v 1.21 2004/11/12 14:11:54 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
#SRC_URI="mirror://gnu/patch/${P}.tar.gz"
#Using own mirrors until gnu has md5sum and all packages up2date
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="build static"

DEPEND="virtual/libc"

src_compile() {
	strip-flags
	CFLAGS="$CFLAGS -DLINUX -D_XOPEN_SOURCE=500"
	# workaround for hardened on amd64, 1st part
	if use amd64 && is-ldflags -pie; then
		einfo Stripping "-pie" from LDFLAGS, adding it to Makefile manually
		filter-ldflags -pie
		append-flags -fPIC
		LDFLAGS_PIE="1"
	fi
	ac_cv_sys_long_file_names=yes \
		./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man
	# workaround for hardened on amd64, 2nd part
	if [ "${LDFLAGS_PIE}" = "1" ]; then
		einfo "Patching Makefile..."
		sed -i -e 's/^LDFLAGS =/& -pie/' Makefile || die "Patching Makefile failed!"
	fi
	use static && append-ldflags -static
	emake LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	einstall || die
	if ! use build ; then
		dodoc AUTHORS ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share/man
	fi
}
