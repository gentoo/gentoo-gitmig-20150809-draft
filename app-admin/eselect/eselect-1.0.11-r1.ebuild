# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect/eselect-1.0.11-r1.ebuild,v 1.10 2009/04/17 13:50:26 ulm Exp $

inherit eutils

DESCRIPTION="Modular -config replacement utility"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="doc bash-completion vim-syntax"

DEPEND="sys-apps/sed
	doc? ( dev-python/docutils )
	|| (
		sys-apps/coreutils
		sys-freebsd/freebsd-bin
		app-admin/realpath
	)"
RDEPEND="sys-apps/sed
	sys-apps/file"

PDEPEND="vim-syntax? ( app-vim/eselect-syntax )"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-fix-paludis-command.patch"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		make html || die "failed to build html"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO doc/*.txt
	use doc && dohtml *.html doc/*

	# we don't use bash-completion.eclass since eselect
	# is listed in RDEPEND.
	if use bash-completion ; then
		insinto /usr/share/bash-completion
		newins misc/${PN}.bashcomp ${PN} || die
	fi
}

pkg_postinst() {
	if use bash-completion ; then
		elog "In case you have not yet enabled command-line completion"
		elog "for eselect, you can run:"
		elog
		elog "  eselect bashcomp enable eselect"
		elog
		elog "to install locally, or"
		elog
		elog "  eselect bashcomp enable --global eselect"
		elog
		elog "to install system-wide."
	fi
}
