# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aserve/cl-aserve-1.2.42.20050805.ebuild,v 1.1 2005/08/14 22:33:29 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:6}
CVS_PV=${PV:7:4}.${PV:11:2}.${PV:13}

DESCRIPTION="A portable version of AllegroServe which is a web application server for Common Lisp programs."
HOMEPAGE="http://portableaserve.sourceforge.net/
	http://packages.debian.org/unstable/web/cl-aserve.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}+cvs.${CVS_PV}.orig.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="=dev-lisp/cl-acl-compat-${PV}*
	=dev-lisp/cl-htmlgen-${PV}*"

CLPACKAGE=aserve

S=${WORKDIR}/cl-portable-aserve-${MY_PV}+cvs.${CVS_PV}.orig

src_install() {
	common-lisp-install aserve/*.cl aserve/*.asd
	common-lisp-system-symlink
	dodoc ChangeLog README README.cmucl INSTALL.lisp logical-hostnames.lisp
	docinto examples
	dodoc contrib/*.lisp
}
