# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.5.9.ebuild,v 1.25 2006/10/17 12:34:55 uberlord Exp $

inherit flag-o-matic

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
#SRC_URI="mirror://gnu/patch/${P}.tar.gz"
#Using own mirrors until gnu has md5sum and all packages up2date
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86"
IUSE="build static"

DEPEND=""

src_compile() {
	strip-flags
	append-flags -DLINUX -D_XOPEN_SOURCE=500
	use static && append-ldflags -static

	local myconf=""
	[[ ${USERLAND} != "GNU" ]] && myconf="--program-prefix=g"
	ac_cv_sys_long_file_names=yes econf ${myconf} || die

	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
	use build && rm -r "${D}"/usr/share
}
