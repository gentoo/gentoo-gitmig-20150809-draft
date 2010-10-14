# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm2targz/rpm2targz-9.0.0.4g.ebuild,v 1.2 2010/10/14 01:41:16 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="Convert a .rpm file to a .tar.gz archive"
HOMEPAGE="http://www.slackware.com/config/packages.php"
SRC_URI="mirror://gentoo/${P}.tar.lzma"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="app-arch/cpio"
DEPEND="app-arch/xz-utils"

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc *.README*
}
