# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion-config/bash-completion-config-0.8-r2.ebuild,v 1.8 2008/05/04 21:43:21 mr_bones_ Exp $

inherit eutils

MY_PN="bashcomp-config"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Utility to easily add/remove bash-completions to your environment"
HOMEPAGE="http://developer.berlios.de/projects/bashcomp-config/"
SRC_URI="mirror://berlios/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=app-shells/bash-2.05"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-fix-all.diff
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS TODO ChangeLog README

	insinto /usr/share/bash-completion
	newins "${FILESDIR}"/bashcomp ${PN} || die "failed to install bashcomp"
}

# remove files that bashcomp-config provides for non-Gentoo platforms
pkg_preinst() {
	[[ -e ${ROOT}/etc/profile.d/bash-completion ]] && rm -fr "${D}"/etc
	rm -fr "${D}"/usr/share/${PN}
}

pkg_postinst() {
	echo
	elog "To enable command-line completion for bash-completion-config,"
	elog "run the following as root:"
	elog
	elog " bash-completion-config --global --install bash-completion-config"
	echo
}
