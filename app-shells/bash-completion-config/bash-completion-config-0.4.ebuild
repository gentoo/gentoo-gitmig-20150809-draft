# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion-config/bash-completion-config-0.4.ebuild,v 1.1 2004/11/03 14:55:43 ka0ttic Exp $

MY_PN="bashcomp-config"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Utility to easily add/remove bash-completions to your environment"
HOMEPAGE="http://developer.berlios.de/projects/bashcomp-config/"
SRC_URI="http://download.berlios.de/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64"
IUSE=""

RDEPEND=">=app-shells/bash-2.05"
DEPEND="${RDEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS TODO ChangeLog README
}

pkg_postinst() {
	echo
	einfo "To enable command-line completion for bash-completion-config,"
	einfo "run the following as root:"
	einfo
	einfo " bash-completion-config --global --install bash-completion-config"
	echo
}
