# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/entropy/entropy-1.0_rc38.ebuild,v 1.2 2011/11/02 21:42:15 vapier Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python

DESCRIPTION="Entropy Package Manager foundation library"
HOMEPAGE="http://www.sabayon.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
SRC_URI="mirror://sabayon/${CATEGORY}/${P}.tar.bz2"

RDEPEND="dev-db/sqlite[soundex]
	net-misc/rsync
	sys-apps/diffutils
	sys-apps/sandbox
	>=sys-apps/portage-2.1.9
	sys-devel/gettext"
DEPEND="${RDEPEND}
	dev-util/intltool"

REPO_CONFPATH="${ROOT}/etc/entropy/repositories.conf"
ENTROPY_CACHEDIR="${ROOT}/var/lib/entropy/caches"

pkg_setup() {
	# Can:
	# - update repos
	# - update security advisories
	# - handle on-disk cache (atm)
	enewgroup entropy
	# Create unprivileged entropy user
	enewgroup entropy-nopriv
	enewuser entropy-nopriv -1 -1 -1 entropy-nopriv
}

src_compile() {
	# TODO: move to separate package
	cd "${S}"/misc/po || die
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="usr/lib" entropy-install || die "make install failed"

	# TODO: move to separate package
	cd "${S}"/misc/po || die
	emake DESTDIR="${D}" LIBDIR="usr/lib" install || die "make install failed"
}

pkg_postinst() {

	# Copy config file over
	if [ -f "${REPO_CONFPATH}.example" ] && [ ! -f "${REPO_CONFPATH}" ]; then
		einfo "Copying ${REPO_CONFPATH}.example over to ${REPO_CONFPATH}"
		cp "${REPO_CONFPATH}.example" "${REPO_CONFPATH}" -p
	fi
	if [ -d "${ENTROPY_CACHEDIR}" ]; then
		einfo "Purging current Entropy cache"
		rm -rf "${ENTROPY_CACHEDIR}"/*
	fi

	python_mod_optimize "/usr/lib/entropy/libraries/entropy"

	# force python 2.x
	eselect python update --ignore 3.0 --ignore 3.1 --ignore 3.2 --ignore 3.3

	echo
	elog "If you want to enable Entropy packages delta download support, please"
	elog "install dev-util/bsdiff."
	echo

}

pkg_postrm() {
	python_mod_cleanup "/usr/lib/entropy/libraries/entropy"
}
