# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grsecurity-base-policy/grsecurity-base-policy-20030614.ebuild,v 1.2 2003/06/21 21:19:39 drobbins Exp $

S=${WORKDIR}/grsecurity-base-policy

DESCRIPTION="Template access control lists for gentoo grsecurity"
HOMEPAGE="http://cvs.gentoo.org/~solar/snapshots"
SRC_URI="mirror://gentoo/${P}.tar.gz"
KEYWORDS="x86 amd64"
LICENSE="GPL-2"
SLOT="0"
MAINTAINER="solar@gentoo.org"
IUSE=""

DEPEND="virtual/glibc \
	sys-apps/sed"

RDEPEND=">=sys-apps/gradm-1.9.9h-r1"

src_install() {
	GRACL_DIR=/etc/grsec/gentoo/grsecurity-base-policy/
	count=0;

	cd ${S}

	/bin/mkdir -m 0700 -p ${D}/${GRACL_DIR} || die "Cant set permissions on ${D}/${GRACL_DIR}"
	echo "include <${GRACL_DIR}>" > ${D}/etc/grsec/acl
	/bin/cp default.acl ${D}/${GRACL_DIR}/

	for pkg in `/usr/lib/portage/bin/pkglist | /bin/sed 's/-[0-9].*//g' | /usr/bin/sort | /usr/bin/uniq`; do
		if [ -d "${pkg}" ] ; then
			for acl in `/bin/ls -1 ${pkg}/*.acl`; do
				count=$(($count + 1))
				einfo "Installing $acl that you need for ${pkg}"
				/bin/mkdir -p ${D}/${GRACL_DIR}/`/usr/bin/dirname $acl`
				/bin/cp $acl ${D}/${GRACL_DIR}/$acl
			done
		fi
	done
	einfo "Installed ${count} ACL's for your system."
}

pkg_postinst() {
	einfo "Note: This package installs its acls based on what you had previously installed"
	einfo "You are encouraged to audit the policy before using in a production enviroment"
	einfo "Bugs can be reported to <${MAINTAINER}> using http://bugs.gentoo.org"
}
