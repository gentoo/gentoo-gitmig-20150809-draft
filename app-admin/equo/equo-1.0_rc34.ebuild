# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/equo/equo-1.0_rc34.ebuild,v 1.1 2011/08/07 16:45:32 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils multilib python bash-completion

DESCRIPTION="Entropy Package Manager text-based client"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"

S="${WORKDIR}/entropy-${PV}"

DEPEND="~sys-apps/entropy-${PV}"
RDEPEND="${DEPEND} sys-apps/file[python]"

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="usr/$(get_libdir)" equo-install || die "make install failed"
	dobashcompletion "${S}/misc/equo-completion.bash" equo
}

pkg_postinst() {
	python_mod_optimize "/usr/$(get_libdir)/entropy/client"
	bash-completion_pkg_postinst
	echo
	elog "If you would like to allow users in the 'entropy' group"
	elog "to update available package repositories, please consider"
	elog "to install sys-apps/entropy-client-services"
	echo
}

pkg_postrm() {
	python_mod_cleanup "/usr/$(get_libdir)/entropy/client"
}
