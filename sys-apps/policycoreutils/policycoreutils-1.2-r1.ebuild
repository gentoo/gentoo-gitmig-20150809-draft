# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-1.2-r1.ebuild,v 1.2 2003/10/29 16:16:21 method Exp $

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

RDEPEND="${DEPEND}
	!build? ( sys-apps/mkinitrd )"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2-gentoo.diff

	# remove -lattr from Makefiles
	SUBDIRS="load_policy newrole run_init setfiles"
	for i in ${SUBDIRS}; do
		sed -i -e 's:-lattr::g' ${i}/Makefile
	done

	# overwrite the /etc/pam.d files with ones
	# that work with our pam setup
	cp -f ${FILESDIR}/newrole ${S}/newrole/newrole.pamd
	cp -f ${FILESDIR}/run_init ${S}/run_init/run_init.pamd
}

src_compile() {

	use build && SUBDIRS="setfiles" \
		|| SUBDIRS="load_policy newrole run_init setfiles"

	for i in ${SUBDIRS}; do
		einfo "Compiling ${i}"
		cd ${S}/${i}
		emake EXTRA_CFLAGS="${CFLAGS}" || die
	done
}

src_install() {
	if use build; then
		dosbin ${S}/setfiles/setfiles
	else
		make DESTDIR="${D}" install

		dosbin ${FILESDIR}/rlpkg
		dobin ${FILESDIR}/{avc_enforcing,avc_toggle}
	fi
}
