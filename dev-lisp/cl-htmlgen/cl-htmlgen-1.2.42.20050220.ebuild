# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-htmlgen/cl-htmlgen-1.2.42.20050220.ebuild,v 1.2 2005/03/18 08:03:15 mkennedy Exp $

inherit common-lisp

MY_PV=${PV:0:6}
CVS_PV=${PV:7:4}.${PV:11:2}.${PV:13}

DESCRIPTION="Franz's library for generating HTML from Common Lisp programs"
HOMEPAGE="http://portableaserve.sourceforge.net/
	http://packages.debian.org/unstable/web/cl-htmlgen.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}+cvs.${CVS_PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="=dev-lisp/cl-acl-compat-${PV}*"

CLPACKAGE=htmlgen

S=${WORKDIR}/cl-portable-aserve-${MY_PV}+cvs.${CVS_PV}

src_install() {
	common-lisp-install aserve/htmlgen/*.cl aserve/htmlgen/*.asd
	common-lisp-system-symlink
	do-debian-credits
	dodoc ChangeLog
}
