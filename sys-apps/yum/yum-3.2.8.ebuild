# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yum/yum-3.2.8.ebuild,v 1.4 2008/01/06 18:39:03 vapier Exp $

NEED_PYTHON=1
inherit python eutils

DESCRIPTION="automatic updater and package installer/remover for rpm systems"
HOMEPAGE="http://linux.duke.edu/projects/yum/"
SRC_URI="http://linux.duke.edu/projects/yum/download/${PV:0:3}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	app-arch/rpm
	dev-python/sqlitecachec
	dev-python/celementtree
	dev-libs/libxml2
	dev-python/urlgrabber"

pkg_setup() {
	_built_with_use() {
		local pkg=$1 ; shift
		if ! built_with_use ${pkg} "$@" ; then
			eerror "You need to install ${pkg} with USE='$*'"
			die "re-emerge ${pkg} with USE='$*'"
		fi
	}
	_built_with_use dev-libs/libxml2 python
	_built_with_use dev-lang/python sqlite
	_built_with_use app-arch/rpm python
}

src_install() {
	python_version
	emake install DESTDIR="${D}" || die
	rm -r "${D}"/etc/rc.d || die
	find "${D}" -name '*.py[co]' -print0 | xargs -0 rm -f
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/{yum,rpmUtils} "${ROOT}"/usr/share/yum-cli
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/{yum,rpmUtils} "${ROOT}"/usr/share/yum-cli
}
