# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grsecurity-base-policy/grsecurity-base-policy-20030516.ebuild,v 1.1 2003/05/17 02:40:13 method Exp $

S=${WORKDIR}/grsecurity-base-policy

DESCRIPTION="Sample ACLS for grsecurity"
SRC_URI="ftp://linbsd.net/pub/people/solar/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.linbsd.net/"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE=""

DEPEND="virtual/glibc \
	sys-apps/fileutils \
	sys-apps/textutils \
	sys-apps/sh-utils \
	sys-apps/sed"

RDEPEND=">=sys-apps/gradm-1.9.9h-r1"

src_install() {
	GRACL_DIR=/etc/grsec/gentoo/grsecurity-base-policy/
	count=0;

	cd ${S}

	/bin/mkdir -p ${D}/${GRACL_DIR}
	echo "include <${GRACL_DIR}>" > ${D}/etc/grsec/acl
	/bin/cp default.acl ${D}/${GRACL_DIR}/

	for pkg in `/usr/lib/portage/bin/pkglist | /bin/sed 's/-[0-9].*//g' | /usr/bin/sort | /usr/bin/uniq`; do
		if [ -d "${pkg}" ] ; then
			for acl in `/bin/ls -1 ${pkg}/*.acl`; do
				count=$(($count + 1))
				#echo "Found $acl that you need for ${pkg}"
				/bin/mkdir -p ${D}/${GRACL_DIR}/`/usr/bin/dirname $acl`
				/bin/cp $acl ${D}/${GRACL_DIR}/$acl
			done
		fi
	done
	einfo "Found and installed ${count} acls for your system."
}
