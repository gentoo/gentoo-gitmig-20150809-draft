# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/uwsgi/uwsgi-0.9.6.6.ebuild,v 1.2 2011/01/10 10:54:39 dev-zero Exp $

EAPI="3"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit eutils python toolchain-funcs apache-module

DESCRIPTION="uWSGI server for Python web applications"
HOMEPAGE="http://projects.unbit.it/uwsgi/"
SRC_URI="http://projects.unbit.it/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}"

APXS2_S="${S}/apache2"
APACHE2_MOD_CONF="42_mod_${PN}"
want_apache2_2

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo-gcc.patch"
	python_copy_sources
}

src_compile() {
	python_src_compile CC="$(tc-getCC)"

	if use apache2 ; then
		for m in Ruwsgi uwsgi ; do
			APXS2_ARGS="-c mod_${m}.c"
			apache-module_src_compile
		done
	fi
}

src_install() {
	installation() {
		newbin uwsgi uwsgi-${PYTHON_ABI}
	}
	python_execute_function -s installation

	python_generate_wrapper_scripts "${ED}usr/bin/uwsgi"

	if use apache2; then
		for m in Ruwsgi uwsgi ; do
			APACHE2_MOD_FILE="${APXS2_S}/.libs/mod_${m}.so"
			apache-module_src_install
		done
	fi
}

pkg_postinst() {
	python_pkg_postinst

	if use apache2 ; then
		elog "Two Apache modules have been installed: mod_uwsgi and mod_Ruwsgi."
		elog "You can enable them with -DUWSGI or -DRUWSGI in /etc/conf.d/apache2."
		elog "Both have the same configuration interface and define the same symbols."
		elog "Therefore you can enable only one of them at a time."
		elog "mod_uwsgi is commercially supported by Unbit and stable but a bit hacky."
		elog "mod_Ruwsgi is newer and more Apache-API friendly but not commercially supported."
	fi
}
