# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/dialign-t/dialign-t-0.2.1.ebuild,v 1.1 2006/02/21 20:50:32 spyderous Exp $

inherit multilib toolchain-funcs

MY_P="DIALIGN-T_${PV}"
DESCRIPTION="An improved algorithm for segment-based multiple sequence alignment"
HOMEPAGE="http://dialign-t.gobics.de/"
SRC_URI="http://dialign-t.gobics.de/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_compile() {
	cd ${S}/source
	emake clean
	emake \
		CPPFLAGS="${CFLAGS}" \
		|| die "make failed"
}

src_install() {
	DESTTREE="/usr" dobin ${S}/source/dialign-t
	dohtml ${S}/doc/html/*
	dodoc ${S}/doc/user_guide*
	insinto /usr/$(get_libdir)/${PN}/conf
	doins ${S}/conf/*
}

pkg_postinst() {
	ewarn "The configuration directory is"
	ewarn "${ROOT}usr/$(get_libdir)/${PN}/conf"
	ewarn "You will need to pass this to ${PN} on every run."
}
