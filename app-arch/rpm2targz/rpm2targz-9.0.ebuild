# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm2targz/rpm2targz-9.0.ebuild,v 1.10 2004/10/05 10:59:23 pvdabeel Exp $

inherit eutils gcc

DESCRIPTION="Convert a .rpm file to a .tar.gz archive"
HOMEPAGE="http://www.slackware.com/config/packages.php"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa"
IUSE=""

# NOTE: rpm2targz autodetects rpm2cpio at runtime, and uses it if available,
#       so we don't explicitly set it as a dependency.
DEPEND="virtual/libc
	app-arch/cpio
	sys-apps/file"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	$(gcc-getCC) ${CFLAGS} -o rpmoffset rpmoffset.c || die
}

src_install() {
	dobin rpmoffset rpm2targz || die
	dodoc rpm2targz.README
}
