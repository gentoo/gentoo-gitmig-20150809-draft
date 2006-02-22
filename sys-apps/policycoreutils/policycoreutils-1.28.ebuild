# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-1.28.ebuild,v 1.7 2006/02/22 17:01:06 spb Exp $

IUSE="build nls pam"

inherit eutils

EXTRAS_VER="1.14"
SEMNG_VER="1.4"

DESCRIPTION="SELinux core utilities"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz
	mirror://gentoo/policycoreutils-extra-${EXTRAS_VER}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 mips ppc sparc x86"

RDEPEND=">=sys-libs/libselinux-${PV}
	!build? ( pam? ( sys-libs/pam ) =sys-libs/libsemanage-${SEMNG_VER}* )
	build? ( sys-apps/baselayout )"

DEPEND="${RDEPEND}
	!build? ( nls? ( sys-devel/gettext ) )"

S2=${WORKDIR}/policycoreutils-extra

throw_pam_warning() {
	# this is an extremely important message that needs to be seen
	# thus it being shown at the beginning and end of the ebuild

	if ! useq pam; then
		eerror "PAM is disabled.  This is not a supported config for"
		eerror "general use.  Disabling PAM decreases security with"
		eerror "respect to SELinux protection of authentication."
		eerror "It also requires policy changes."
		ebeep 4
		epause 4
	fi
}

pkg_setup() {
	throw_pam_warning
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/policycoreutils-1.28-quietlp.diff
	epatch ${FILESDIR}/policycoreutils-unsigned-char-ppc.diff

	# This warning makes no sense, in this context
	sed -i -e '/FILE/ s/;/=NULL;/' ${S}/audit2why/audit2why.c \
		|| die "audit2why sed failed"

	# fixfiles is extremely dangerous
	sed -i -e '/^all/s/fixfiles//' ${S}/scripts/Makefile \
		|| die "fixfiles sed 1 failed"
	sed -i -e '/fixfiles/d' ${S}/scripts/Makefile \
		|| die "fixfiles sed 2 failed"

	if ! useq pam; then
		# disable pam
		sed -i -e s/-lpam/-lcrypt/ -e s/-lpam_misc// -e s/-DUSE_PAM// \
			${S}/run_init/Makefile || die "PAM sed 1 failed"
		sed -i -e s/-lpam/-lcrypt/ -e s/-lpam_misc// -e s/-DUSE_PAM// \
			${S}/newrole/Makefile || die "PAM sed 2 failed"
		sed -i -e s/-lpam/-lcrypt/ -e s/-lpam_misc// -e s/-DUSE_PAM// \
			${S2}/src/Makefile || die "PAM sed 3 failed"
	fi

	if ! useq nls; then
		# disable locale stuff
		sed -i -e s/-DUSE_NLS// ${S}/run_init/Makefile \
			|| die "NLS sed 1 failed"
		sed -i -e s/-DUSE_NLS// ${S}/newrole/Makefile \
			|| die "NLS sed 2 failed"
		sed -i -e s/-DUSE_NLS// ${S}/load_policy/Makefile \
			|| die "NLS sed 3 failed"
		sed -i -e 's/ po //' ${S}/Makefile \
			|| die "NLS sed 4 failed"
	fi

	# fix up to accept Gentoo CFLAGS
	local SUBDIRS="`cd ${S} && find -type d | cut -d/ -f2`"
	for i in ${SUBDIRS}; do
		sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" ${S}/${i}/Makefile \
			|| die "${i} Makefile CFLAGS fix failed."
	done
}

src_compile() {
	if useq build; then
		einfo "Compiling setfiles"
		emake -C ${S}/setfiles || die
	else
		einfo "Compiling policycoreutils"
		emake -C ${S} || die
		einfo "Compiling policycoreutils-extra"
		emake -C ${S2} || die
	fi
}

src_install() {
	if useq build; then
		dosbin ${S}/setfiles/setfiles
	else
		einfo "Installing policycoreutils"
		make DESTDIR="${D}" -C ${S} install || die
		einfo "Installing policycoreutils-extra"
		make DESTDIR="${D}" -C ${S2} install || die
	fi

	useq pam || rm -fR ${D}/etc/pam.d
}

pkg_postinst() {
	if useq build; then
		# need to ensure these
		mkdir -p ${ROOT}/selinux
		touch ${ROOT}/selinux/.keep
		mkdir -p ${ROOT}/sys
		touch ${ROOT}/sys/.keep
		mkdir -p ${ROOT}/dev/pts
		touch ${ROOT}/dev/pts/.keep
		chmod 0666 ${ROOT}/dev/{ptmx,tty}
	fi

	throw_pam_warning
}
