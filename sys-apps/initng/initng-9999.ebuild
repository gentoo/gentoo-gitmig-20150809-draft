# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/initng/initng-9999.ebuild,v 1.12 2007/08/25 17:59:38 vapier Exp $

ESVN_REPO_URI="http://svn.initng.org/initng/trunk"
ESVN_PROJECT="initng"
inherit subversion multilib

DESCRIPTION="A next generation init replacement"
HOMEPAGE="http://initng.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.1"
PDEPEND="sys-apps/initng-ifiles"

S=${WORKDIR}/${PN}

plugin_warning() {
	if [[ -z ${INITNG_PLUGINS} ]] ; then
		einfo "If you want to customize the list of initng plugins, please"
		einfo "set the INITNG_PLUGINS variable in your make.conf."
		einfo "See http://www.initng.org/wiki/Documents_Plugins for a list of"
		einfo "valid plugins for you to choose from."
	fi
}

pkg_setup() {
	plugin_warning
}

src_compile() {
	local x default_opts valid_opts cmake_opts=""
	valid_opts=$(sed -n   '/^OPTION/        s:.*(\([[:alpha:]_]*\).*:\1:p' CMakeLists.txt)
	default_opts=$(sed -n '/^OPTION(.*ON)$/ s:.*(\([[:alpha:]_]*\).*:\1:p' CMakeLists.txt)
	INITNG_PLUGINS=$(echo ${INITNG_PLUGINS} | tr '[:lower:]' '[:upper:]')
	INITNG_PLUGINS=${INITNG_PLUGINS:-${default_opts}}
	for x in ${valid_opts} ; do
		if hasq ${x} ${INITNG_PLUGINS} || hasq ${x#BUILD_} ${INITNG_PLUGINS} ; then
			cmake_opts="${cmake_opts} -D${x}=ON"
		else
			cmake_opts="${cmake_opts} -D${x}=OFF"
		fi
	done
	cmake \
		-DCMAKE_INSTALL_PREFIX=/ \
		-DLIB_INSTALL_DIR=/$(get_libdir) \
		${cmake_opts} || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	find "${D}" -name '*.a' -exec rm "{}" \;
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	plugin_warning
	einfo "Remember to add init=/sbin/initng in your grub or lilo config"
	einfo " in order to use initng.  Happy testing!"
}
