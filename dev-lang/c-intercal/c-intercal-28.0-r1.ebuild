# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/c-intercal/c-intercal-28.0-r1.ebuild,v 1.1 2008/12/15 20:57:17 ulm Exp $

inherit elisp-common eutils multilib versionator

# Yes, C-INTERCAL uses minor-major...
MY_PV=$(get_version_component_range 2).$(get_version_component_range 1)

DESCRIPTION="C-INTERCAL - INTERCAL to binary (via C) compiler"
HOMEPAGE="http://intercal.freeshell.org"
SRC_URI="http://intercal.freeshell.org/download/ick-${MY_PV/./-}.tgz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs examples"

DEPEND="emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ick-${MY_PV}"
SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fix-install-info.patch"
	epatch "${FILESDIR}/${P}-fix-64bit.patch"
	epatch "${FILESDIR}/${P}-parallel-make.patch"

	# This was done for DOS compatiblity it seems. Go figure...
	ln -s config.sh configure || die "ln -s failed"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"

	if use emacs; then
		elisp-compile etc/intercal.el || die
	fi
}

src_install() {
	# Thinks the directories exist, won't as this is done to a DESTDIR...
	dodir /usr/bin
	dodir /usr/$(get_libdir)
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc BUGS.txt NEWS.txt README.txt doc/THEORY.txt

	if use emacs; then
		elisp-install ${PN} etc/intercal.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r pit || die "doins -r pit failed"
	fi
}
