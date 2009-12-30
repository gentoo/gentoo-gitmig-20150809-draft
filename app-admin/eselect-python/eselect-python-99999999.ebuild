# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-python/eselect-python-99999999.ebuild,v 1.4 2009/12/30 22:05:59 arfrever Exp $

EAPI="2"

inherit flag-o-matic subversion toolchain-funcs

DESCRIPTION="Eselect module for management of multiple Python versions"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.3"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	>=sys-devel/gcc-3.4"

ESVN_PROJECT="eselect-python"
ESVN_REPO_URI="https://overlays.gentoo.org/svn/proj/python/projects/eselect-python/trunk"

pkg_setup() {
	append-flags -fno-PIC -fno-PIE

	if [[ $(gcc-major-version) -lt 3 || ($(gcc-major-version) -eq 3 && $(gcc-minor-version) -lt 4) ]]; then
		die "GCC >=3.4 is required"
	fi
}

src_prepare() {
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
