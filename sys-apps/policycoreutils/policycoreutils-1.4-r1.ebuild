# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-1.4-r1.ebuild,v 1.1 2004/02/10 03:55:05 pebenito Exp $

IUSE="build"

EXTRAS_VER="1.0"

DESCRIPTION="SELinux core utilites"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz
	mirror://gentoo/policycoreutils-extra-${EXTRAS_VER}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="sys-libs/libselinux
	sys-devel/gettext
	!build? ( sys-libs/pam )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}
S2=${WORKDIR}/policycoreutils-extra

src_unpack() {
	unpack ${A}

	# trivial fix to audit2allow
	sed -i -e 's:newrules:$0:' ${S}/audit2allow/audit2allow

	# fix up to accept Gentoo CFLAGS
	local SUBDIRS="load_policy newrole run_init setfiles audit2allow"
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

		exeinto /sbin
		newexe ${FILESDIR}/selinux-init seinit
	fi
}
