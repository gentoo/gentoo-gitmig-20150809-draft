# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wgetpaste/wgetpaste-2.13.ebuild,v 1.5 2009/07/03 13:47:20 ranger Exp $

DESCRIPTION="Command-line interface to various pastebins"
HOMEPAGE="http://wgetpaste.zlin.dk/"
SRC_URI="http://wgetpaste.zlin.dk/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="zsh-completion"

DEPEND=""
RDEPEND="net-misc/wget
	zsh-completion? ( app-shells/zsh )"

src_install() {
	dobin ${PN} || die "Failed to install wgetpaste"
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins _wgetpaste || die "Failed to install zsh-completions"
	fi
}
