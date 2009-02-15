# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mead/mead-2.2.7.ebuild,v 1.1 2009/02/15 22:57:07 dirtyepic Exp $

inherit eutils python

DESCRIPTION="Macroscopic Electrostatics with Atomic Detail"
HOMEPAGE="http://www.scripps.edu/mb/bashford/"
SRC_URI="ftp://ftp.scripps.edu/pub/bashford/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="python"

RESTRICT="fetch"

RDEPEND="python? ( dev-python/numeric )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )"

pkg_nofetch() {
	elog "Download ${SRC_URI}"
	elog "and place it in ${DISTDIR}."
	elog
	elog "Use \"anonymous\" as a login, and an email address as a password."
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-respect-cflags.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	if use python; then
		python_version
		conf_opts="${conf_opts} --with-py-site-packages-dir=${D}/usr/$(get_libdir)/python${PYVER}/site-packages"
	fi

	econf \
		$(use_with python) \
		${conf_opts} \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	# package hates emake DESTDIR="${D}" install
	einstall || die "install failed"
}
