# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-python/eselect-python-20090824.ebuild,v 1.10 2009/10/04 01:56:58 arfrever Exp $

EAPI="1"

inherit eutils flag-o-matic

DESCRIPTION="Eselect module for management of multiple Python versions"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.2"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

pkg_setup() {
	append-flags -fno-PIC -fno-PIE
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-old-glibc.patch"
	./autogen.sh || die "autogen.sh failed"
}

src_install() {
	keepdir /etc/env.d/python
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_preinst() {
	if has_version "<${CATEGORY}/${PN}-20090804" || ! has_version "${CATEGORY}/${PN}"; then
		run_eselect_python_update="1"
	fi
}

pkg_postinst() {
	if [[ "${run_eselect_python_update}" == "1" ]]; then
		ebegin "Running \`eselect python update\`"
		eselect python update --ignore 3.0 --ignore 3.1 --ignore 3.2 > /dev/null
		eend "$?"
	fi
}
