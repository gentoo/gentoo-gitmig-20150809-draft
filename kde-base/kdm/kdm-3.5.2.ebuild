# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdm/kdm-3.5.2.ebuild,v 1.5 2006/04/22 11:15:57 carlo Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5.0-patches-1.tar.bz2"

DESCRIPTION="KDE login manager, similar to xdm and gdm"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="pam"

KMEXTRA="kdmlib/"
# kioslave/thumbnail/configure.in.in is to have HAVE_LIBART. Can be dropped on
# 3.5_beta1.
KMEXTRACTONLY="libkonq/konq_defaults.h"
#	    kioslave/thumbnail/configure.in.in"
KMCOMPILEONLY="kcontrol/background"
DEPEND="pam? ( kde-base/kdebase-pam )
	$(deprange $PV $MAXKDEVER kde-base/kcontrol)"
	# Requires the desktop background settings and kdm kcontrol modules
RDEPEND="${DEPEND}
	kde-base/kdepasswd"


src_unpack() {
	unpack "kdebase-3.5.0-patches-1.tar.bz2"
	kde-meta_src_unpack

	# Avoid using imake (kde bug 114466)
	epatch "${WORKDIR}/patches/kdebase-3.5.0_beta2-noimake.patch"
}

src_compile() {
	local myconf="--with-x-binaries-dir=/usr/bin"

	if use pam; then
		myconf="${myconf} --with-pam=yes"
	else
		myconf="${myconf} --with-pam=no --with-shadow"
	fi

	export USER_LDFLAGS="${LDFLAGS}"

	kde-meta_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde-meta_src_compile make
}

src_install() {
	kde-meta_src_install
	cd ${S}/kdm && make DESTDIR=${D} GENKDMCONF_FLAGS="--no-old --no-backup --no-in-notice" install

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		${D}/${KDEDIR}/share/config/kdm/kdmrc || die
}

pkg_postinst() {
	# set the default kdm face icon if it's not already set by the system admin
	# because this is user-overrideable in that way, it's not in src_install
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ];	then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
		    "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon" ]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi
}
