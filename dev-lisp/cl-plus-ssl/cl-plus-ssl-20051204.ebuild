# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-plus-ssl/cl-plus-ssl-20051204.ebuild,v 1.1 2006/09/02 18:07:25 mkennedy Exp $

inherit common-lisp eutils multilib

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"
DESCRIPTION="Common Lisp interface to libcurl, a multi-protocol file transfer library"
HOMEPAGE="http://sourceforge.net/projects/cl-curl/"
SRC_URI="http://common-lisp.net/project/cl-plus-ssl/download/cl+ssl-${MY_PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""
DEPEND=">=dev-lisp/cl-cffi-0.9.1
	dev-lisp/cl-trivial-gray-streams
	dev-lisp/cl-flexi-streams"

CLPACKAGE=cl+ssl

S=${WORKDIR}/cl+ssl-${MY_PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/20051204-cffi-null-pointer-gentoo.patch || die
	rm ${S}/Makefile
	sed -i "s,/usr/lib,/usr/$(get_libdir),g" ${S}/cl+ssl.asd
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc LICENSE
	dohtml index.{css,html}
}
