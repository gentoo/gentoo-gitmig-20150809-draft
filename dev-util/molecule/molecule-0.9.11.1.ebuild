# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/molecule/molecule-0.9.11.1.ebuild,v 1.1 2010/07/22 11:51:25 lxnay Exp $

EAPI="2"
PYTHON_DEPEND="*"

inherit multilib python

DESCRIPTION="Release metatool used for creating Sabayon (and Gentoo) releases"
HOMEPAGE="http://www.sabayon.org"
SRC_URI="http://distfiles.sabayon.org/dev-util/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/intltool
	sys-devel/gettext"
RDEPEND="net-misc/rsync
	sys-fs/squashfs-tools
	virtual/cdrtools"

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" \
		PREFIX="/usr" SYSCONFDIR="/etc" install \
		|| die "emake install failed"
}

pkg_postinst() {
	python_mod_optimize "/usr/$(get_libdir)/molecule"
}

pkg_postrm() {
	python_mod_cleanup "/usr/$(get_libdir)/molecule"
}
