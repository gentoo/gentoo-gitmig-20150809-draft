# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-asdf/cl-asdf-1.73b.ebuild,v 1.1 2003/06/07 19:39:53 mkennedy Exp $

DESCRIPTION="Another System Definition Facility for Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-asdf.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-asdf/${PN}_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${P}

src_install() {
	insinto /usr/share/common-lisp/source/asdf
	doins asdf.lisp wild-modules.lisp

	dodoc LICENSE README
	insinto /usr/share/doc/${P}/examples
	doins test/*
}

pkg_postinst() {
	if [ -x /usr/sbin/clc-reregister-all-impl ]; then
		/usr/sbin/clc-reregister-all-impl
	fi
}


### from debian cl-clan.postinst:

# #!/bin/sh
 
# set -e
 
# pkg=cclan
 
# # summary of how this script can be called:
# #        * <postinst> `configure' <most-recently-configured-version>
# #        * <old-postinst> `abort-upgrade' <new version>
# #        * <conflictor's-postinst> `abort-remove' `in-favour' <package>
# #          <new-version>
# #        * <deconfigured's-postinst> `abort-deconfigure' `in-favour'
# #          <failed-install-package> <version> `removing'
# #          <conflicting-package> <version>
# # for details, see http://www.debian.org/doc/debian-policy/ or
# # the debian-policy package
# #
# # quoting from the policy:
# #     Any necessary prompting should almost always be confined to the
# #     post-installation script, and should be protected with a conditional
# #     so that unnecessary prompting doesn't happen if a package's
# #     installation fails and the `postinst' is called with `abort-upgrade',
# #     `abort-remove' or `abort-deconfigure'.
 
# case "$1" in
#     configure)
#         /usr/sbin/register-common-lisp-source $pkg
#         ;;
#     abort-upgrade|abort-remove|abort-deconfigure)
#         ;;
#     *)
#         echo "postinst called with unknown argument \`$1'" >&2
#         exit 1
#         ;;
# esac
 
# #DEBHELPER#
 
# exit 0
