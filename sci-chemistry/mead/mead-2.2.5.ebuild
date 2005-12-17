# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mead/mead-2.2.5.ebuild,v 1.1 2005/12/17 21:02:40 spyderous Exp $

inherit eutils python

DESCRIPTION="Macroscopic Electrostatics with Atomic Detail"
HOMEPAGE="http://www.scripps.edu/mb/bashford/"
SRC_URI="ftp://ftp.scripps.edu/pub/bashford/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="python"
RESTRICT="fetch"
RDEPEND=""
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )"

pkg_nofetch() {
	einfo "Download ${SRC_URI}"
	einfo "and place it in ${DISTDIR}."
	einfo "Use anonymous as a login, password an email address."
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/respect-cflags.patch
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
	einstall || die "install failed"
}
