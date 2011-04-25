# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sepolgen/sepolgen-1.0.17-r1.ebuild,v 1.4 2011/04/25 19:07:08 arfrever Exp $

EAPI="3"

inherit python

IUSE=""

DESCRIPTION="SELinux policy generation library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/current/devel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=">=dev-lang/python-2.5
	>=sys-libs/libselinux-2.0"

src_prepare() {
	# fix up default paths to not be RH specific
	sed -i -e 's:/usr/share/selinux/devel:/usr/share/selinux/strict:' \
		"${S}/src/sepolgen/defaults.py" || die
	sed -i -e 's:/usr/share/selinux/devel:/usr/share/selinux/strict/include:' \
		"${S}/src/sepolgen/module.py" || die
}

src_compile() {
	return
}

src_test() {
	if has_version sec-policy/selinux-base-policy; then
		make test
	else
		ewarn "Sepolgen requires sec-policy/selinux-base-policy to run tests."
	fi
}

src_install() {
	python_need_rebuild
	make DESTDIR="${D}" PYTHONLIBDIR="$(python_get_sitedir)" \
		 install || die "install failed"
}

pkg_postinst() {
	python_mod_optimize sepolgen
}

pkg_postrm() {
	python_mod_cleanup sepolgen
}
