# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/gentoo-bashcomp/gentoo-bashcomp-20091225.ebuild,v 1.1 2009/12/26 04:45:32 darkside Exp $

DESCRIPTION="Gentoo-specific bash command-line completions (emerge, ebuild, equery, repoman, layman, etc)"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="app-shells/bash-completion"

src_install() {
	insinto /usr/share/bash-completion
	doins gentoo 	|| die "failed to install gentoo module"
	doins repoman 	|| die "failed to install repoman module"
	doins layman 	|| die "failed to install layman module"
	dodoc AUTHORS ChangeLog TODO
}

pkg_postinst() {
	# can't use bash-completion.eclass.
	elog "To enable command-line completion for ${PN}, run:"
	elog
	elog "  eselect bashcomp enable gentoo"
	elog
	elog "to install locally, or"
	elog
	elog "  eselect bashcomp enable --global gentoo"
	elog
	elog "to install system-wide. (and/or repoman instead of gentoo if you use"
	elog "repoman frequently)"
}
