# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-araneida/cl-araneida-0.9.ebuild,v 1.1 2005/02/10 09:18:29 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Araneida is small, highly-portable web server for Common Lisp"
HOMEPAGE="http://www.cliki.net/Araneida"
SRC_URI="http://www-jcsu.jesus.cam.ac.uk/ftp/pub/cclan/araneida_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-www/apache
	dev-lisp/cl-split-sequence
	dev-lisp/cl-net-telent-date"

CLPACKAGE=araneida

S=${WORKDIR}/araneida_${PV}

src_install() {
	insinto $CLSOURCEROOT/araneida
	doins *.asd *.lisp NEWS
	insinto $CLSOURCEROOT/araneida/utility
	doins utility/*.lisp
	insinto $CLSOURCEROOT/araneida/compat
	doins compat/*.lisp
	insinto $CLSOURCEROOT/araneida/doc
	doins doc/*.html doc/*.css doc/*.lisp doc/PLAN
	common-lisp-system-symlink
	dohtml doc/*.html doc/*.css
	insinto /usr/share/doc/${PF}/examples/
	doins doc/*.lisp
	dodoc doc/*.txt new-dispatch-model
}
