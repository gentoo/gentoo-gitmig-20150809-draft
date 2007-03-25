# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-1.34.1.ebuild,v 1.2 2007/03/25 20:19:17 pebenito Exp $

IUSE="nls pam"

inherit eutils python

EXTRAS_VER="1.17"
SEMNG_VER="1.10"
SELNX_VER="1.34"

# BUGFIX_PATCH="${FILESDIR}/policycoreutils-1.30.6.diff"

DESCRIPTION="SELinux core utilities"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz
	mirror://gentoo/policycoreutils-extra-${EXTRAS_VER}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~mips ppc ~sparc x86"

RDEPEND=">=sys-libs/libselinux-${SELNX_VER}
	>=sys-libs/glibc-2.4
	pam? ( sys-libs/pam )
	=sys-libs/libsemanage-${SEMNG_VER}*"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

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

	[ ! -z "${BUGFIX_PATCH}" ] && epatch "${BUGFIX_PATCH}"

	# This warning makes no sense, in this context
	sed -i -e '/FILE/ s/;/=NULL;/' ${S}/audit2why/audit2why.c \
		|| die "audit2why sed failed"

	# rlpkg is more useful than fixfiles
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
		sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" \
			-e '/^AUDITH/d' \
			${S}/${i}/Makefile \
			|| die "${i} Makefile CFLAGS fix failed."

		# disable audit support because the required version
		# in portage does not exist yet
	done
}

src_compile() {
	python_version

	einfo "Compiling policycoreutils"
	emake -C ${S} PYLIBVER="python${PYVER}" || die
	einfo "Compiling policycoreutils-extra"
	emake -C ${S2} || die
}

src_install() {
	python_version

	einfo "Installing policycoreutils"
	make DESTDIR="${D}" -C ${S} PYLIBVER="python${PYVER}" install || die
	einfo "Installing policycoreutils-extra"
	make DESTDIR="${D}" -C ${S2} install || die

	# remove redhat-style init script
	rm -fR ${D}/etc/rc.d

	# compatibility symlink
	dosym /sbin/setfiles /usr/sbin/setfiles

	if ! useq pam; then
		rm -fR ${D}/etc/pam.d
	else
		if has_version '<sys-libs/pam-0.99'; then
			# install compat pam.d entries
			# for older pam
			make DESTDIR="${D}" -C ${S2}/pam.d install || die
		fi
	fi			
}

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}usr/lib/python${PYVER}/site-packages

	throw_pam_warning
}

pkg_postrm() {
	python_version
	python_mod_cleanup ${ROOT}usr/lib/python${PYVER}/site-packages
}
