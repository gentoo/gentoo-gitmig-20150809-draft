# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/entrance/entrance-9999.ebuild,v 1.11 2006/08/11 00:53:26 vapier Exp $

inherit enlightenment eutils

DESCRIPTION="next generation of Elogin, a login/display manager for X"
HOMEPAGE="http://xcomputerman.com/pages/entrance.html"
SRC_URI="${SRC_URI}
	mirror://gentoo/extraicons-1.tar.bz2
	http://wh0rd.de/gentoo/distfiles/extraicons-1.tar.bz2"

IUSE="pam"

RDEPEND="|| ( x11-libs/libXau virtual/x11 )
	pam? ( sys-libs/pam )
	>=dev-db/edb-1.0.5
	>=x11-libs/evas-0.9.9
	>=x11-libs/ecore-0.9.9
	>=media-libs/edje-0.5.0
	>=x11-libs/esmart-0.9.0"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11	)"

src_compile() {
	if use pam ; then
		export MY_ECONF="--with-auth-mode=pam"
	else
		export MY_ECONF="--with-auth-mode=shadow"
	fi
	MY_ECONF="${MY_ECONF} $(use_enable pam)"
	enlightenment_src_compile
}

src_install() {
	enlightenment_src_install
	use pam || rm -r "${D}"/etc/pam.d
	rm -rf "${D}"/etc/init.d
	insinto /usr/share/entrance/images/sessions
	doins "${WORKDIR}"/extraicons/*
	exeinto /usr/share/entrance
	doexe data/config/build_config.sh || die
}

pkg_preinst() {
	if [[ -d ${ROOT}/etc/X11/Sessions ]] ; then
		"${D}"/usr/share/entrance/build_config.sh \
			-c "${D}"/etc/entrance_config.cfg \
			-d "${ROOT}"/etc/X11/Sessions
	fi
}
