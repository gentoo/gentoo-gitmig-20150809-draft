# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yum/yum-2.6.1.ebuild,v 1.2 2006/08/28 11:05:44 chrb Exp $

inherit python distutils eutils

DESCRIPTION="Automatic updater and package installer/remover for rpm systems"
HOMEPAGE="http://linux.duke.edu/projects/yum/"
SRC_URI="${HOMEPAGE}/download/${PV%.[0-9]}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="dev-python/celementtree
	>=dev-python/urlgrabber-2.9.6
	dev-libs/libxml2
	>=app-arch/rpm-4.4.1"

DEPEND=""

PYTHON_MODNAME="yum repomd rpmUtils"

pkg_setup() {
	if ! built_with_use dev-libs/libxml2 python
	then
		eerror "dev-libs/libxml2 wasn't built with the python use flag set!"
		eerror "Add python to USE in /etc/make.conf and run"
		eerror "'emerge --oneshot dev-libs/libxml2'"
		die "need dev-libs/libxml2 built with python support."
	fi
	if !  built_with_use app-arch/rpm python
	then
		eerror "app-arch/rpm wasn't built with the python use flag set!"
		eerror "Add python to USE in /etc/make.conf and run"
		eerror "'emerge --oneshot app-arch/rpm'"
		die "need app-arch/rpm built with python support."
	fi
}


src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README AUTHORS ChangeLog TODO
	useq doc && dodoc PLUGINS

	# Makefile explicitly compiles python files
	find ${D}/usr/ -name *.py[co] -exec rm {} \;

	# yum's auto-update functionality doesn't make
	# sense for a system managed by portage
	rm -rf ${D}/etc/cron.{daily,weekly}
	rm -rf ${D}/etc/{rc.d,yum}
}

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}usr/share/${PN}-cli
	distutils_pkg_postinst
}

pkg_postrm() {
	python_version
	python_mod_cleanup ${ROOT}usr/share/${PN}-cli
	distutils_pkg_postrm
}
