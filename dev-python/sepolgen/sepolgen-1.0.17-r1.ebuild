# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sepolgen/sepolgen-1.0.17-r1.ebuild,v 1.1 2009/12/16 01:55:00 pebenito Exp $

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

src_unpack() {
	unpack ${A}

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
	python_version
	python_need_rebuild
	make DESTDIR="${D}" PYTHONLIBDIR="/usr/$(get_libdir)/python${PYVER}/site-packages" \
		 install || die "install failed"
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages
}
