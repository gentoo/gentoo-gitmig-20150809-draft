# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-1.4.ebuild,v 1.2 2003/12/16 20:44:51 pebenito Exp $

IUSE="build"

DESCRIPTION="SELinux core utilites"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="sys-libs/libselinux
	sys-devel/gettext
	!build? ( sys-libs/pam )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}

	# trivial fix to audit2allow
	sed -i -e 's:newrules:$0:' audit2allow/audit2allow

	# fix up to accept Gentoo CFLAGS
	SUBDIRS="load_policy newrole run_init setfiles audit2allow"
	for i in ${SUBDIRS}; do
		sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" ${i}/Makefile \
			|| die "${i} Makefile CFLAGS fix failed."
	done

	# overwrite the /etc/pam.d files with ones
	# that work with our pam setup
	cp -f ${FILESDIR}/newrole ${S}/newrole/newrole.pamd
	cp -f ${FILESDIR}/run_init ${S}/run_init/run_init.pamd
}

src_compile() {

	use build && SUBDIRS="setfiles" \
		|| SUBDIRS="load_policy newrole run_init setfiles audit2allow"

	for i in ${SUBDIRS}; do
		einfo "Compiling ${i}"
		cd ${S}/${i}
		emake || die
	done
}

src_install() {
	if use build; then
		dosbin ${S}/setfiles/setfiles
	else
		make DESTDIR="${D}" install

		dosbin ${FILESDIR}/rlpkg
		dobin ${FILESDIR}/avc_toggle

		dosym /usr/bin/getenforce /usr/bin/avc_enforcing

		exeinto /sbin
		newexe ${FILESDIR}/selinux-init seinit
	fi
}
