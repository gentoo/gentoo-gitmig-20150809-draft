# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wgetpaste/wgetpaste-2.18.ebuild,v 1.1 2010/08/06 21:29:57 wired Exp $

DESCRIPTION="Command-line interface to various pastebins"
HOMEPAGE="http://wgetpaste.zlin.dk/"
SRC_URI="http://wgetpaste.zlin.dk/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
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
