# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bash-completion-config/bash-completion-config-0.2.ebuild,v 1.5 2004/11/04 09:45:56 kumba Exp $

MY_PN="bashcomp-config"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Utility to easily add/remove bash-completions to your environment"
HOMEPAGE="http://developer.berlios.de/projects/bashcomp-config/"
SRC_URI="ftp://ftp.berlios.de/pub/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~x86 ~mips ~sparc"
IUSE=""

RDEPEND=">=app-shells/bash-2.05"
DEPEND="${RDEPEND}"

src_compile() {
	econf || die "econf failed"
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1 || die

	insinto /usr/share/bash-completion
	newins completion ${PN}

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
