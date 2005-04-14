# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/common-lisp-controller/common-lisp-controller-4.12.ebuild,v 1.4 2005/04/14 07:15:36 mkennedy Exp $

inherit eutils

DESCRIPTION="Common Lisp Controller"
HOMEPAGE="http://packages.debian.org/unstable/devel/common-lisp-controller.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/common-lisp-controller/${PN}_${PV}.tar.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc ppc ~mips ~ppc-macos ~amd64"
IUSE=""

DEPEND="app-admin/realpath
	>=dev-lisp/cl-asdf-1.84
	!ppc-macos? ( virtual/logger )"

# Nothing requires defsystem anymore
#	>=cl-defsystem3-3.3i-r3

S=${WORKDIR}/clc

src_unpack() {
	unpack ${A}
	# remove
	epatch ${FILESDIR}/${PV}-user-clc-systems-gentoo.patch || die
}

src_install() {
	# user package support not in v4
#	dobin clc-register-user-package
#	dobin clc-unregister-user-package
	dosbin register-common-lisp-implementation
	dosbin register-common-lisp-source
	dosbin unregister-common-lisp-implementation
	dosbin unregister-common-lisp-source
	insinto /usr/share/common-lisp/source/common-lisp-controller
	doins common-lisp-controller.lisp
	doins post-sysdef-install.lisp

#	doman man/clc-register-user-package.1
	doman man/register-common-lisp-implementation.8

#	dosym /usr/share/man/man1/clc-register-user-package.1.gz \
#		/usr/share/man/man1/clc-unregister-user-package.1.gz
	dosym /usr/share/man/man8/register-common-lisp-implementation.8.gz \
		/usr/share/man/man8/unregister-common-lisp-implementation.8.gz
	dosym /usr/share/man/man8/register-common-lisp-implementation.8.gz \
		/usr/share/man/man8/register-common-lisp-source.8.gz
	dosym /usr/share/man/man8/register-common-lisp-implementation.8.gz \
		/usr/share/man/man8/unregister-common-lisp-source.8.gz

	insinto /etc
	doins ${FILESDIR}/${PV}/lisp-config.lisp

	dodoc ${FILESDIR}/README.Gentoo
	dodoc DESIGN.txt
}

pkg_postinst() {

	test -d /var/cache/common-lisp-controller \
		|| mkdir /var/cache/common-lisp-controller
	chmod 1777 /var/cache/common-lisp-controller

	# This code from ${S}/debian/postinst

	for compiler in /usr/lib/common-lisp/bin/*.sh
	do
		if [ -f "${compiler}" -a -r "${compiler}" -a -x "${compiler}" ] ; then
			i=${compiler##*/}
			i=${i%.sh}
			einfo ">>> Recompiling Common Lisp Controller for $i"
			bash "$compiler" install-clc || true
			einfo ">>> Done rebuilding"
		fi
	done

	# This code from ${S}/debian/preinst

	# cleanup fasl files:
	( find /usr/share/common-lisp/source/defsystem \
		/usr/share/common-lisp/source/asdf \
		/usr/share/common-lisp/source/common-lisp-controller -type f -not -name "*.lisp" -print0 \
		| xargs --null rm --force 2> /dev/null ) &>/dev/null

	# remove old autobuild files:
#	find /etc/common-lisp -name autobuild -print0 \
#		| xargs -0 rm 2> /dev/null || true
#	find /etc/common-lisp -type d -depth -print0 \
#		| xargs rmdir 2> /dev/null || true

	# remove old fals files:
	test -d /usr/lib/common-lisp-controller \
		&& rmdir --ignore-fail-on-non-empty /usr/lib/common-lisp-controller
	for compiler in /usr/lib/common-lisp/bin/*.sh ; do
		if [ -f "$compiler" -a -r "$compiler" ] ; then
			i=${compiler##*/}
			i=${i%.sh}
			if [ -d "/usr/lib/common-lisp/${i}" ] ; then
				rm -rf "/usr/lib/common-lisp/${i}"
			fi
		fi
	done
}
