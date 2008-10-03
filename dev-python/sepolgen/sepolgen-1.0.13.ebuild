# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sepolgen/sepolgen-1.0.13.ebuild,v 1.1 2008/10/03 03:46:23 pebenito Exp $

inherit python

IUSE=""

DESCRIPTION="SELinux policy generation library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/current/devel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=">=dev-lang/python-2.5
	>=sys-libs/libselinux-2.0"

src_compile() {
	return
}

src_install() {
	python_version
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
