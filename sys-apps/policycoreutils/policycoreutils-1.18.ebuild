# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-1.18.ebuild,v 1.1 2004/11/14 19:09:35 pebenito Exp $

IUSE="build"

inherit eutils

EXTRAS_VER="1.9"

DESCRIPTION="SELinux core utilities"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz
	mirror://gentoo/policycoreutils-extra-${EXTRAS_VER}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND=">=sys-libs/libselinux-${PV}
	sys-libs/libsepol
	sys-devel/gettext
	!build? ( sys-libs/pam )"

S2=${WORKDIR}/policycoreutils-extra

src_unpack() {
	unpack ${A}

	cd ${S}

	# add compatibility for number of genhomedircon command line args
#	epatch ${FILESDIR}/policycoreutils-1.16-genhomedircon-compat.diff

	# dont install fixfiles cron script
	sed -i -e '/^all/s/fixfiles//' ${S}/scripts/Makefile \
		|| die "fixfiles sed 1 failed"
	sed -i -e '/fixfiles/d' ${S}/scripts/Makefile \
		|| die "fixfiles sed 2 failed"

	# fix up to accept Gentoo CFLAGS
	local SUBDIRS="`cd ${S} && find -type d | cut -d/ -f2`"
	for i in ${SUBDIRS}; do
		sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" ${S}/${i}/Makefile \
			|| die "${i} Makefile CFLAGS fix failed."
	done
}

src_compile() {
	if use build; then
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
	if use build; then
		dosbin ${S}/setfiles/setfiles
	else
		einfo "Installing policycoreutils"
		make DESTDIR="${D}" -C ${S} install || die
		einfo "Installing policycoreutils-extra"
		make DESTDIR="${D}" -C ${S2} install || die
	fi
}
