# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-libvirt-schemas/nxml-libvirt-schemas-0.8.2.ebuild,v 1.1 2010/07/25 18:35:39 flameeyes Exp $

BACKPORTS=

EAPI=2

inherit elisp eutils

MY_P="libvirt-${PV}"

DESCRIPTION="Extension for nxml-mode with libvirt schemas"
HOMEPAGE="http://www.libvirt.org/"

SRC_URI="http://libvirt.org/sources/${MY_P}.tar.gz
	${BACKPORTS:+mirror://gentoo/${MY_P}-backports-${BACKPORTS}.tar.bz2}"

# This is the license of the package, but the schema files are
# provided without license, maybe it's bad.
LICENSE="LGPL-2.1"

SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( >=app-emacs/nxml-mode-20041004-r3 >=virtual/emacs-23 )"

# Yes this requires Java, but I'd rather not repackage this, if you
# know something better in C, I'll be glad to use that.
DEPEND="app-text/trang"

SITEFILE=60${PN}-gentoo.el

S="${WORKDIR}/${MY_P}"

src_prepare() {
	[[ -d "${WORKDIR}/patches" ]] && \
		EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" EPATCH_SOURCE="${WORKDIR}/patches" epatch
}

src_compile() {
	emake -C docs/schemas -f "${FILESDIR}/Makefile-trang" || die "trang failed"
}

src_test() {
	# No we don't need tests here… trang will take care of checking
	# the well-formedness of the schema files for us
	:
}

src_install() {
	insinto ${SITEETC}/${PN}
	doins "${FILESDIR}/schemas.xml" docs/schemas/*.rnc || die "install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}

pkg_postinst () {
	elisp-site-regen

	if [ $(emacs -batch -q --eval "(princ (fboundp 'nxml-mode))") = nil ]; then
		ewarn "This package needs nxml-mode. You should either install"
		ewarn "app-emacs/nxml-mode, or use \"eselect emacs\" to select"
		ewarn "an Emacs version >= 23."
	fi
}